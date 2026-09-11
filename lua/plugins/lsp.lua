return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      local vue_language_server_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
      vim.lsp.config('vtsls', {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_language_server_path,
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                },
              },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      })

      -- nvim-lspconfig already provides the Vue hybrid-mode handler which
      -- forwards TypeScript requests to vtsls.
      vim.lsp.config('vue_ls', {})

      vim.lsp.config('emmet_ls', {
        filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      })

      vim.lsp.config('bashls', {
        filetypes = { 'sh', 'bash', 'zsh' },
      })

      vim.lsp.config('qmlls', {
        filetypes = { 'qml', 'qmljs' },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
          },
        },
      })

      local ensure_installed = {
        'bashls',
        'emmet_ls',
        'lua_ls',
        'qmlls',
        'vtsls',
        'vue_ls',
      }

      -- Mason owns installation; Neovim owns activation. Disabling Mason's
      -- automatic activation prevents an old ts_ls installation from running.
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_enable = false,
      }

      vim.lsp.enable(ensure_installed)

      vim.diagnostic.config {
        severity_sort = true,
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = false,
        underline = { severity = vim.diagnostic.severity.ERROR },
        update_in_insert = false,
        float = {
          focusable = true,
          style = 'minimal',
          border = 'rounded',
          source = 'if_many',
          header = '',
          prefix = '',
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(event)
          local picker = Snacks.picker
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Neovim 0.12 already defines grn, gra and the other basic LSP
          -- mappings. Keep only the Snacks overrides and extra mappings.
          map('grr', picker.lsp_references, '[G]oto [R]eferences')
          map('gri', picker.lsp_implementations, '[G]oto [I]mplementations')
          map('grd', picker.lsp_definitions, '[G]oto [D]efinitions')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', picker.lsp_symbols, 'Open Document Symbols')
          map('gW', picker.lsp_workspace_symbols, 'Open Workspace Symbols')
          map('grt', picker.lsp_type_definitions, '[G]oto [T]ype Definition')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
            end, '[T]oggle inlay [H]ints')
          end
        end,
      })
    end,
  },
}
