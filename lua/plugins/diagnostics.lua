return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup {
        preset = 'simple',
        transparent_bg = false,
        transparent_cursorline = false,
        hi = {
          error = 'DiagnosticError',
          warn = 'DiagnosticWarn',
          info = 'DiagnosticInfo',
          hint = 'DiagnosticHint',
          arrow = 'NonText',
          background = 'CursorLine',
          mixing_color = 'None',
        },
        options = {
          show_source = { enabled = true, if_many = true },
          show_code = true,
          use_icons_from_diagnostic = true,
          set_arrow_to_diag_color = true,
          add_messages = {
            messages = true,
            display_count = true,
            use_max_severity = true,
            show_multiple_glyphs = true,
          },
          throttle = 20,
          softwrap = 40,
          multilines = {
            enabled = false,
            always_show = false,
          },
          show_all_diags_on_cursorline = true,
          show_related = { enabled = true, max_count = 3 },
          enable_on_insert = false,
          enable_on_select = false,
          overflow = { mode = 'wrap', padding = 2 },
          break_line = { enabled = false, after = 40 },
          format = nil,
          virt_texts = { priority = 2048 },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
          overwrite_events = nil,
        },
        disabled_ft = {},
      }

      vim.keymap.set('n', '<leader>td', '<cmd>TinyInlineDiag toggle<CR>', { desc = '[T]oggle Tiny Inline [D]iagnostic' })
      vim.keymap.set('n', '<leader>df', function()
        vim.diagnostic.open_float {
          scope = 'line',
          focusable = true,
        }
      end, { desc = '[D]iagnostic [F]loat' })
    end,
  },
}
