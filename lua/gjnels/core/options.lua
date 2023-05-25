-- Set leader key to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

-- Set highlight on search
opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true
opt.relativenumber = true

-- Enable mouse mode
opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = 'menu,menuone,noselect'

-- Enable true color
opt.termguicolors = true

-- Enable highlighting of the current line
opt.cursorline = true

-- Indentation
opt.shiftwidth = 2 -- Indent size
opt.tabstop = 2 -- Number of spaces in a tab
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true -- Round indent

-- See ':h shortmess'
opt.shortmess:append({ W = true, I = true, c = true })
if vim.fn.has('nvim-0.9.0') == 1 then
  opt.splitkeep = 'screen'
  opt.shortmess:append({ C = true })
end

opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current

-- Remove vim statusline
opt.laststatus = 0
opt.showmode = false
opt.cmdheight = 0

-- Enable auto write
opt.autowrite = true

-- Hide * markup for bold and italic
opt.conceallevel = 3

-- Confirm to save changes before exiting modified buffer
opt.confirm = true

-- Lines of context
opt.scrolloff = 8

-- Grep
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'

-- Preview incremental substitute
opt.inccommand = 'nosplit'

-- Show some invisible characters (tabs...
opt.list = true

-- Popup menus
opt.pumblend = 10 -- Popup transparency
opt.pumheight = 10 -- Maximum number of entries in a popup

-- Session saving
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }

-- Command-line completion mode
opt.wildmode = 'longest:full,full'
