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
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'j-hui/fidget.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      local vue_ts_plugin_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin'

      local servers_list = {
        vtsls = {
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = '@vue/typescript-plugin',
                    location = vue_ts_plugin_path,
                    languages = { 'vue' },
                    configNamespace = 'typescript',
                  },
                },
              },
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        },

        vue_ls = {
          filetypes = { 'vue' },
          on_new_config = function(new_config, new_root_dir)
            local fallback_tsdk = vim.fn.stdpath 'data' .. '/mason/packages/vtsls/node_modules/typescript/lib'
            local project_tsdk = vim.fs.find('node_modules/typescript/lib', { path = new_root_dir, upward = true })[1]
            new_config.init_options = new_config.init_options or {}
            new_config.init_options.typescript = { tsdk = project_tsdk or fallback_tsdk }
          end,
          on_init = function(client)
            local max_retries = 60
            local retry_ms = 500

            local function typescriptHandler(_, result, context)
              local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })[1]
                or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })[1]
                or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'typescript-tools' })[1]

              if not ts_client then
                local retries = (context._vue_retries or 0) + 1
                if retries <= max_retries then
                  context._vue_retries = retries
                  vim.defer_fn(function()
                    typescriptHandler(_, result, context)
                  end, retry_ms)
                else
                  vim.notify('[vue_ls] Could not find vtsls after ' .. (max_retries * retry_ms / 1000) .. 's. Try :LspRestart', vim.log.levels.WARN)
                end
                return
              end

              local param = unpack(result)
              local id, command, payload = unpack(param)
              ts_client:exec_cmd({
                title = 'vue_request_forward',
                command = 'typescript.tsserverRequest',
                arguments = { command, payload },
              }, { bufnr = context.bufnr }, function(_, r)
                client:notify('tsserver/response', { { id, r and r.body } })
              end)
            end

            client.handlers['tsserver/request'] = typescriptHandler
          end,
        },

        emmet_ls = {
          filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        },

        bashls = {
          filetypes = { 'sh', 'bash', 'zsh' },
        },

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method { bufnr = bufnr }
        end
      end

      local lspconfig = require 'lspconfig'

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = true },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local ensure_installed = vim.tbl_keys(servers_list)
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettierd',
        'prettier',
        'eslint_d',
        'vue-language-server',
        'vtsls',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            if server_name == 'ts_ls' then
              return
            end
            local server = servers_list[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            lspconfig[server_name].setup(server)
          end,
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'vue',
        callback = function(ev)
          local root = vim.fs.root(ev.buf, { 'yarn.lock', 'package-lock.json', 'pnpm-lock.yaml', 'bun.lock', '.git' })
          if not root then
            return
          end
          local vtsls_src = servers_list['vtsls'] or {}
          vim.lsp.start(
            vim.tbl_deep_extend('force', vtsls_src, {
              name = 'vtsls',
              cmd = { 'vtsls', '--stdio' },
              root_dir = root,
              capabilities = vim.tbl_deep_extend('force', {}, capabilities, vtsls_src.capabilities or {}),
            }),
            { bufnr = ev.buf }
          )
        end,
        desc = 'Ensure vtsls is running when a .vue file is opened',
      })
    end,
  },

  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = {
        preset = 'default',
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },
}
