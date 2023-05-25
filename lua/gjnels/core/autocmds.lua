-- create auto groups
local function augroup(name)
  return vim.api.nvim_create_augroup('gjnels_' .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = augroup('highlight_on_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize window splits if window is resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- Check if a file was changed and needs to be reloaded
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  command = 'checktime',
})

-- Close specified filetype with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
