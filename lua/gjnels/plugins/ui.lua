return {
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
      icons = {
        ERROR = ' ',
        INFO = ' ',
        WARN = ' ',
      },
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
}
