return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function show_macro_recording()
      return ''

      -- local recording_register = vim.fn.reg_recording()
      -- if recording_register == '' then
      --   return ''
      -- else
      --   return 'recording @' .. recording_register
      -- end
    end

    require('lualine').setup {
      options = {
        theme = 'auto',
        icons_enabled = true,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          'filename',
          {
            show_macro_recording,
            color = { fg = require('lualine.utils.utils').extract_highlight_colors('Comment', 'fg') },
          },
        },
        lualine_x = {
          {
            function()
              return '%S'
            end,
          },
          'searchcount',
          'filetype',
          function()
            return ''
          end,
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}
