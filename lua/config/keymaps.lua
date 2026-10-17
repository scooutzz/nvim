vim.keymap.set('n', '<leader>pv', '<cmd>Ex<CR>', { desc = 'Netrw', silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Open tmux sessionizer' })

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up', silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down', silent = true })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '=ap', "ma=ap'a")

vim.keymap.set('x', '<leader>p', [["_dP"]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'Set file execution permission', silent = true })

vim.keymap.set('n', '<leader>m', '<cmd>Man<CR>', { desc = 'Open Man Page', silent = true })

-- Quickfix list stuff
vim.keymap.set('n', '<leader>cl', ':cclose<CR>', { silent = true })
vim.keymap.set('n', '<leader>co', ':copen<CR>', { silent = true })
vim.keymap.set('n', '<leader>cn', ':cnext<CR>zz')
vim.keymap.set('n', '<leader>cp', ':cprev<CR>zz')

-- Soure file
vim.keymap.set('n', '<leader><leader>', function()
  vim.cmd 'so'
end, { desc = 'Source file' })
