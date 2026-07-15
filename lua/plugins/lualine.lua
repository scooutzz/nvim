return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- local function show_macro_recording()
    --   local recording_register = vim.fn.reg_recording()
    --   if recording_register == '' then
    --     return ''
    --   else
    --     return 'recording @' .. recording_register
    --   end
    -- end

    require('lualine').setup {
      options = {
        theme = 'auto',
        icons_enabled = true,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', path = 1 } },

        lualine_x = { 'diagnostics' },
        lualine_y = { 'filetype' },
        lualine_z = { 'location', 'progress' },
      },
    }
  end,
}
