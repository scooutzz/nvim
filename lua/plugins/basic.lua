return {
  { 'NMAC427/guess-indent.nvim' },

  {
    'folke/which-key.nvim',
    dependencies = {
      'echasnovski/mini.icons',
    },
    event = 'VimEnter',
    opts = {
      preset = 'helix',
      delay = 200,
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
}
