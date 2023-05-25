return {
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },

  {
    'MunifTanjim/nui.nvim',
    lazy = true,
  },

  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },

  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },

  -- session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' } },
    keys = {
      {
        '<leader>qs',
        function()
          require('persistence').load()
        end,
        desc = 'Restore Session',
      },
      {
        '<leader>ql',
        function()
          require('persistence').load({ last = true })
        end,
        desc = 'Restore Last Session',
      },
      {
        '<leader>qd',
        function()
          require('persistence').stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
