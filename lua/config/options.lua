-- line nums
vim.o.number = true
vim.o.relativenumber = true

-- indentation and tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- backspace
vim.o.backspace = 'indent,eol,start'

-- appearance
vim.o.termguicolors = true
vim.o.signcolumn = 'yes'

-- cursor
vim.o.cursorline = true
vim.o.guicursor = ''

-- statusline
vim.o.showcmdloc = 'statusline'
vim.o.showmode = false
vim.o.laststatus = 3

-- column guide and wrapped lines
vim.o.colorcolumn = '80'
vim.o.breakindent = true

-- whitespace markers
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- keep cursor at leat 8 rows from top/bot
vim.o.scrolloff = 8

-- mouse
vim.o.mouse = 'a'

-- split windows
vim.o.splitright = true
vim.o.splitbelow = true

-- filename characters
vim.opt.isfname:append '@-@'

-- dw/diw/ciw works on full-word
vim.opt.iskeyword:append '-'

-- search and substitution
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

-- swap and persistent undo
vim.o.swapfile = false
vim.o.undofile = true

-- idle events and keymap timeout
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- treesitter folds
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel = 99

-- clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
