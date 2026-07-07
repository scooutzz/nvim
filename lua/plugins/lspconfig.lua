return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(event)
          vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', { desc = 'Show LSP [R]eferences' })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]o to [D]eclaration' })
          vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { desc = 'Show LSP [d]efinitions' })
          vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { desc = 'Show LSP [i]mplementations' })
          vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', { desc = 'Show LSP [t]ype definitions' })
          vim.keymap.set({ 'n', 'v' }, '<leader>vca', vim.lsp.buf.code_action, { desc = 'See available [c]ode [a]ctions' })
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Smart [r]ename' })

          vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'Workspace [d]iagnostics (Quickfix)' })
          vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Buffer diagnostics (Location List)' })

          vim.keymap.set('n', 'df', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show documentation for what is under cursor' })
          vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            vim.keymap.set('n', '<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { desc = '[T]oggle inlay [H]ints' })
          end
        end,
      })

      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = '󰠠 ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
        },
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = true,
        },
      }

      vim.keymap.set('n', '<leader>lx', function()
        local current = vim.diagnostic.config().virtual_text
        vim.diagnostic.config { virtual_text = not current }
      end, { desc = 'Toggle LSP virtual text' })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink-cmp').get_lsp_capabilities(capabilities)

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config('nil_ls', {
        settings = {
          ['nil'] = {
            formatting = { command = { 'alejandra' } },
          },
        },
      })

      vim.lsp.config('bashls', {
        filetypes = { 'sh', 'bash', 'zsh' },
      })

      vim.lsp.config('qmlls', {
        cmd = { 'qmlls' },
        filetypes = { 'qml' },
        single_file_support = true,
      })

      vim.lsp.config('emmet_ls', {
        filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
      })

      vim.lsp.enable {
        'bashls',
        'qmlls',
        'nil_ls',
        'emmet_ls',
        'lua_ls',
      }
    end,
  },
}
