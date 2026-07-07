vim.g.have_nerd_font = true
local set = vim.opt

set.termguicolors = true
set.number = true
set.relativenumber = true
set.signcolumn = 'yes'
set.colorcolumn = '100'
set.cursorline = true
set.guicursor = ''
set.showcmdloc = 'statusline'
set.showmode = false
set.laststatus = 3

set.scrolloff = 8
set.mouse = 'a'
set.wrap = false
set.splitright = true
set.splitbelow = true

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true
set.breakindent = true

set.ignorecase = true
set.smartcase = true
set.inccommand = 'split'

set.swapfile = false
set.backup = false
set.undofile = true
set.isfname:append '@-@'

set.updatetime = 250
set.timeoutlen = 300

set.list = true
set.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel = 99

set.confirm = true

vim.schedule(function()
  set.clipboard = 'unnamedplus'
end)
