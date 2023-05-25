local utils = require('gjnels.utils')

-- autocmds and keymaps can wait to load
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    utils.load('autocmds')
    utils.load('keymaps')
  end,
})

utils.load('options')

return {}
