return {
  {
    'neovim/nvim-lspconfig',
    branch = 'master',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/typescript.nvim',
    },
    opts = {
      autoformat = true,
      setup = {
        tsserver = function(_, opts)
          require('gjnels.utils').on_attach(function(client, buffer)
            if client.name == 'tsserver' then
              vim.keymap.set(
                'n',
                '<leader>co',
                '<cmd>TypescriptOrganizeImports<CR>',
                { buffer = buffer, desc = 'Organize Imports' }
              )
              vim.keymap.set(
                'n',
                '<leader>cR',
                '<cmd>TypescriptRenameFile<CR>',
                { desc = 'Rename File', buffer = buffer }
              )
            end
          end)
          require('typescript').setup({ server = opts })
          return true
        end,
      },
    },
    config = function(_, opts)
      -- setup auto-format
      require('gjnels.config.lsp.format').autoformat = opts.autoformat

      -- setup formatting and keymaps
      require('gjnels.utils').on_attach(function(client, buffer)
        require('gjnels.config.lsp.format').on_attach(client, buffer)
        require('gjnels.config.lsp.keymaps').on_attach(client, buffer)
      end)

      local servers = require('gjnels.config.lsp.servers')
      local ext_capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require('gjnels.utils').capabilities(ext_capabilities)

      local function setup(server)
        if servers[server] and servers[server].disabled then
          return
        end

        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      -- get all the servers that are available thourgh mason-lspconfig
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },

  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'Open Mason' },
    },
    opts = {
      ui = {
        border = 'rounded',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
    end,
  },

  -- formatters
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    config = function()
      local null_ls = require('null-ls')
      local formatting = null_ls.builtins.formatting
      null_ls.setup({
        debug = false,
        sources = {
          formatting.prettierd.with({
            extra_filetypes = { 'svelte' },
          }),
          formatting.stylua,
          formatting.beautysh,
        },
      })
    end,
  },

  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'prettierd',
        'stylua',
        'beautysh',
      },
      automatic_setup = true,
    },
  },
}
