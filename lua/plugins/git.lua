return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [s]tatus' })
      vim.keymap.set('n', '<leader>grc', ':Gvdiffsplit!<CR>', { desc = '[G]it [r]esolve [c]onflicts' })
      vim.keymap.set({ 'n', 'v' }, '<leader>grh', ':diffget //2<CR>', { desc = '[G]it [r]esolve target [h]' })
      vim.keymap.set({ 'n', 'v' }, '<leader>grl', ':diffget //3<CR>', { desc = '[G]it [r]esolve merge [l]' })
      vim.keymap.set('n', '<leader>grw', ':Gwrite<CR>', { desc = '[G]it [r]esolve [q]uit' })
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [u]ndotree' })
    end,
  },
}