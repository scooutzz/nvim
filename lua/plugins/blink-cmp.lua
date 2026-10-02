return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'folke/lazydev.nvim',
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      list = { selection = { auto_insert = false } },
      documentation = { window = { border = 'rounded' } },
    },
    signature = { enabled = true },
    sources = {
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        snippets = { opts = { use_label_description = true } },
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    snippets = { preset = 'luasnip' },
  },
}
