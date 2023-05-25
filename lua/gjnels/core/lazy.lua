local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup({
  spec = {
    { import = 'gjnels.core.resources' },
    { import = 'gjnels.plugins' },
  },
  defaults = {
    lazy = false, -- lazy-loading off by default
    version = '*', -- try to install latest stable version
  },
  checker = { enabled = true },
  install = { colorscheme = { 'tokyonight' } },
  ui = { border = 'rounded' },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
