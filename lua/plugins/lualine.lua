return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
        icons_enabled = true,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { { 'mode', color = { gui = 'bold' } } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'fileformat' },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = { 'location' },
      },
    }
  end,
}
