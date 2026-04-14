return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    require('rainbow-delimiters.setup').setup {
      strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
        html = 'rainbow-blocks',
        tsx = 'rainbow-blocks',
        jsx = 'rainbow-blocks',
        vue = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
    }
  end,
}
