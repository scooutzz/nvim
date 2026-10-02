return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { bufnr = 0 }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = 'fallback',
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        vue = { 'prettierd', 'prettier' },
        css = { 'prettierd', 'prettier' },
        scss = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
      },
      formatters = {
        ['clang-format'] = {
          prepend_args = function(_, ctx)
            local config = vim.fs.find({ '.clang-format', '_clang-format' }, { path = ctx.dirname, upward = true, type = 'file' })[1]
            if config then
              return {}
            end
            return { '--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never, AllowShortFunctionsOnASingleLine: None}' }
          end,
        },
      },
    },
  },
}
