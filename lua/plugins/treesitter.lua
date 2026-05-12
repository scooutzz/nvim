return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        -- 'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        -- 'markdown',
        -- 'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'typescript',
        'javascript',
        'css',
        'scss',
        'json',
        'vue',
        'gitignore',
        'gitcommit',
      },
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby', 'typescript', 'vue' } },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = false,
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
          },
        },
      }
    end,
  },
}
