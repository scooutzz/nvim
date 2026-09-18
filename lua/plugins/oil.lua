return {
  {
    'stevearc/oil.nvim',
    dependencies = {
      { 'echasnovski/mini.icons', lazy = false },
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ['<C-p>'] = false,
        ['<C-h>'] = false,
        ['<C-s>'] = false,
        ['<C-l>'] = false,
        ['gp'] = 'actions.preview',
        ['gh'] = { 'actions.select', opts = { horizontal = true } },
        ['gv'] = { 'actions.select', opts = { vertical = true } },
        ['gr'] = 'actions.refresh',
      },
      win_options = {
        signcolumn = 'yes:2', -- required for oil-git-status
      },
    },
    config = function(_, opts)
      local oil = require 'oil'
      oil.setup(opts)

      vim.keymap.set('n', '<leader>pv', oil.open, { desc = 'Open Oil' })
    end,
    lazy = false,
  },
  {
    'refractalize/oil-git-status.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    config = true,
  },
}
