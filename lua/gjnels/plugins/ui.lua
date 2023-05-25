return {
  -- notifications
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>n',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        desc = 'Delete all Notifications',
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      local utils = require('gjnels.utils')
      if not utils.has('noice.nvim') then
        utils.on_very_lazy(function()
          vim.notify = require('notify')
        end)
      end
    end,
  },

  -- better vim ui
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },

  -- indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '│',
      filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- active indent guide and indent text objects
  {
    'echasnovski/mini.indentscope',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- noicer looking ui
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = require('gjnels.config.noice.opts'),
    keys = require('gjnels.config.noice.keys'),
  },

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    },
    opts = {
      options = {
        close_command = function(n)
          require('mini.bufremove').delete(n, false)
        end,
        right_mouse_command = function(n)
          require('mini.bufremove').delete(n, false)
        end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require('gjnels.core.icons').diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
  },

  -- dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      require('gjnels.config.dashboard')
    end,
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      local icons = require('gjnels.core.icons')
      local Util = require('gjnels.utils')

      return {
        options = {
          theme = 'auto',
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = {
            {
              'diagnostics',
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
            {
              function()
                return require('nvim-navic').get_location()
              end,
              cond = function()
                return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
              end,
            },
          },
          lualine_x = {
            {
              function()
                return require('noice').api.status.command.get()
              end,
              cond = function()
                return package.loaded['noice'] and require('noice').api.status.command.has()
              end,
              color = Util.fg('Statement'),
            },
            {
              function()
                return require('noice').api.status.mode.get()
              end,
              cond = function()
                return package.loaded['noice'] and require('noice').api.status.mode.has()
              end,
              color = Util.fg('Constant'),
            },
            {
              function()
                return '  ' .. require('dap').status()
              end,
              cond = function()
                return package.loaded['dap'] and require('dap').status() ~= ''
              end,
              color = Util.fg('Debug'),
            },
            { require('lazy.status').updates, cond = require('lazy.status').has_updates, color = Util.fg('Special') },
            {
              'diff',
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return ' ' .. os.date('%R')
            end,
          },
        },
        extensions = { 'neo-tree', 'lazy' },
      }
    end,
  },
}
