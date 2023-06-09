return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    keys = {
      { '<c-space>', desc = 'Increment selection' },
      { '<bs>', desc = 'Decrement selection', mode = 'x' },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        'bash',
        'css',
        'go',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'query', -- Tree-Sitter query language
        'regex',
        'rust',
        'scss',
        'sql',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      local ensure_installed = opts.ensure_installed
      if type(ensure_installed) == 'table' then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = true,
    init = function()
      -- disable plugin when it is not needed
      local plugin = require('lazy.core.config').spec.plugins['nvim-treesitter']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local enabled = false
      if opts.textobjects then
        for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
          if opts.textobjects[mod] and opts.textobjects[mod].enable then
            enabled = true
            break
          end
        end
      end
      if not enabled then
        require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
      end
    end,
  },
}
