return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    init = function()
      local parsers = {
        'lua',
        'luadoc',
        'vim',
        'vimdoc',
        'query',
        'javascript',
        'typescript',
        'vue',
        'html',
        'css',
        'scss',
        'json',
        'markdown',
        'markdown_inline',
        'diff',
        'gitignore',
        'gitcommit',
        'c',
      }

      local group = vim.api.nvim_create_augroup('RelaxouTreesitter', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
        group = group,
        callback = function()
          if vim.bo.buftype ~= '' then
            return
          end
          pcall(vim.treesitter.start, 0)
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          require('nvim-treesitter').install(parsers)

          pcall(function()
            require('nvim-treesitter.configs').setup {
              highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
              },
              indent = { enable = true, disable = { 'ruby', 'typescript', 'vue' } },
            }
          end)
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = false,
    config = function()
      pcall(function()
        require('nvim-treesitter.configs').setup {
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
              },
            },
          },
        }
      end)
    end,
  },
}
