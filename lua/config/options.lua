vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.guicursor = ''
vim.o.showcmdloc = 'statusline'
vim.o.showmode = false
vim.o.laststatus = 3

vim.o.scrolloff = 8
vim.o.mouse = 'a'
vim.o.wrap = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.colorcolumn = '100'

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.opt.isfname:append '@-@'

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel = 99

vim.o.confirm = true

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
