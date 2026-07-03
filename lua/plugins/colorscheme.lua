local function get_current_theme()
  local name = 'rose-pine' -- Fallback
  local state_path = vim.fn.stdpath 'state' .. '/current-theme'

  local f = io.open(state_path, 'r')
  if f then
    local content = f:read('*all'):gsub('%s+', '')
    if content ~= '' then
      name = content
    end
    f:close()
  end

  return name
end

local initial_theme = get_current_theme()

return {
  { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = false, priority = 1000 },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 1000 },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    init = function()
      vim.api.nvim_create_autocmd('ColorSchemePre', {
        pattern = 'gruvbox-material',
        callback = function()
          local current = get_current_theme()
          -- background: 'hard', 'medium', 'soft'
          -- foreground: 'original', 'material', 'mix'

          if current == 'gruvbox' then
            vim.g.gruvbox_material_background = 'medium'
            vim.g.gruvbox_material_foreground = 'original'
          else
            vim.g.gruvbox_material_background = 'medium'
            vim.g.gruvbox_material_foreground = 'material'
          end
        end,
      })
    end,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },
  { 'sainnhe/everforest', lazy = false, priority = 1000 },
  { 'shaunsingh/nord.nvim', lazy = false, priority = 1000 },

  {
    'config-theme',
    virtual = true,
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
          vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })

          vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
          vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
        end,
      })

      local themes = {
        ['tokyo-night'] = 'tokyonight-night',
        ['rose-pine'] = 'rose-pine',
        ['catppuccin-mocha'] = 'catppuccin-mocha',
        ['gruvbox'] = 'gruvbox-material',
        ['gruvbox-material'] = 'gruvbox-material',
        ['everforest'] = 'everforest',
        ['nord'] = 'nord',
      }

      local final_theme = themes[initial_theme] or initial_theme

      local ok, err = pcall(vim.cmd.colorscheme, final_theme)
      if not ok then
        vim.cmd.colorscheme 'rose-pine'
      end
    end,
  },
}
