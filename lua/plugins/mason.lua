return {
  {
    'mason-org/mason.nvim',
    opts = {},
    cmd = 'Mason',
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = {
        'eslint_d',
        'prettier',
        'prettierd',
        'stylua',
        'clang-format',
      },
    },
  },
  {
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        window = {
          winblend = 0,
          border = 'rounded',
        },
      },
    },
  },
}
