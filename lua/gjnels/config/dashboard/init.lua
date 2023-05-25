local dashboard = require('gjnels.config.dashboard.layout')

if vim.o.filetype == 'lazy' then
  vim.cmd.close()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'AlphaReady',
    callback = function()
      require('lazy').show()
    end,
  })
end

require('alpha').setup(dashboard.opts)

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
    local stats = require('lazy').stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
    pcall(vim.cmd.AlphaRedraw)
  end,
})
