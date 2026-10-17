return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-k>'] = 'move_selection_previous',
              ['<C-j>'] = 'move_selection_next',
              ['<C-q>'] = 'smart_send_to_qflist',
            },
          },
        },
      }

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<C-p>', function()
        builtin.find_files {
          find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/' },
        }
      end)
      vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = 'Telescope oldfiles' })
      vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = 'Telescope quickfix ' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
      vim.keymap.set('n', '<leader>sg', function()
        builtin.grep_string { search = vim.fn.input 'Grep > ' }
      end, { desc = 'Telescope grep string' })
      vim.keymap.set('n', '<leader>sG', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Telescope grep word' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Telescope Neovim files' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Telescope resume' })
    end,
  },
}
