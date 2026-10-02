return {
  'christoomey/vim-tmux-navigator',
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    { '<M-h>', '<cmd>TmuxNavigateLeft<cr>', desc = 'Navigate left' },
    { '<M-j>', '<cmd>TmuxNavigateDown<cr>', desc = 'Navigate down' },
    { '<M-k>', '<cmd>TmuxNavigateUp<cr>', desc = 'Navigate up' },
    { '<M-l>', '<cmd>TmuxNavigateRight<cr>', desc = 'Navigate right' },
    { '<M-\\>', '<cmd>TmuxNavigatePrevious<cr>', desc = 'Navigate to previous pane' },
  },
}
