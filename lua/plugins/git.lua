return {
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [u]ndotree' })
    end,
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [s]tatus' })
      vim.keymap.set('n', '<leader>grc', ':Gvdiffsplit!<CR>', { desc = '[G]it [r]esolve [c]onflicts' })
      vim.keymap.set({ 'n', 'v' }, '<leader>grh', ':diffget //2<CR>', { desc = '[G]it [r]esolve target [h]' })
      vim.keymap.set({ 'n', 'v' }, '<leader>grl', ':diffget //3<CR>', { desc = '[G]it [r]esolve merge [l]' })
      vim.keymap.set('n', '<leader>grw', ':Gwrite<CR>', { desc = '[G]it [r]esolve [q]uit' })
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })

        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })

        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })

        map('n', '<leader>hc', function()
          local blame = vim.b.gitsigns_blame_line_dict
          if blame and blame.sha then
            gitsigns.diffthis(blame.sha .. '^')
          else
            vim.notify('No blame information available for this line', vim.log.levels.WARN)
          end
        end, { desc = 'git [c]ommit parent diff' })

        map('n', '<leader>hC', function()
          local blame = vim.b.gitsigns_blame_line_dict
          if blame and blame.sha then
            gitsigns.diffthis(blame.sha)
          else
            vim.notify('No blame information available for this line', vim.log.levels.WARN)
          end
        end, { desc = 'git [C]ommit diff' })

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
}
