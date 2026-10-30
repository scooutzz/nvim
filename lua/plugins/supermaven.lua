return {
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<M-l>',
          clear_suggestion = '<M-]>',
          accept_word = '<M-k>',
        },
      }
    end,
  },
}
