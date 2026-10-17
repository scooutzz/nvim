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
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
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

      vim.lsp.config('clangd', {
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { 'compile_commands.json', '.clangd', 'configure.ac', 'Makefile', '.git' },
      })

      local ensure_installed = {
        'bashls',
        'emmet_ls',
        'lua_ls',
        'qmlls',
        'vtsls',
        'vue_ls',
        'clangd',
      }

      -- Mason owns installation; Neovim owns activation. Disabling Mason's
      -- automatic activation prevents an old ts_ls installation from running.
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_enable = false,
      }

      vim.lsp.enable(ensure_installed)

      vim.diagnostic.config {
        virtual_text = true,
        severity_sort = true,
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
          },
        } or {},
        float = {
          style = 'minimal',
          border = 'rounded',
          source = 'if_many',
          header = '',
          prefix = '',
        },
      }

      local orig = vim.lsp.util.open_floating_preview
      ---@diagnostic disable-next-line: duplicate-set-field
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or 'rounded'
        opts.max_width = opts.max_width or 80
        opts.max_height = opts.max_height or 24
        opts.wrap = opts.wrap ~= false
        return orig(contents, syntax, opts, ...)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          local buf = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          map('n', 'K', vim.lsp.buf.hover)
          map('n', 'gd', vim.lsp.buf.definition)
          map('n', 'gD', vim.lsp.buf.declaration)
          map('n', 'gs', vim.lsp.buf.signature_help)
          map('n', 'gl', vim.diagnostic.open_float)

          if client:supports_method 'textDocument/documentHighlight' then
            local highlight_augroup = vim.api.nvim_create_augroup('my.lsp.highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
}
