local theme_name = 'rose-pine' -- Fallback

local state_path = vim.fn.stdpath 'state' .. '/current-theme'

local f = io.open(state_path, 'r')
if f then
  -- Lê o conteúdo, remove espaços/quebras de linha e fecha
  local content = f:read('*all'):gsub('%s+', '')
  if content ~= '' then
    theme_name = content
  end
  f:close()
end

return {
  { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = false, priority = 1000 },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 1000 },
  { 'ellisonleao/gruvbox.nvim', lazy = false, priority = 1000 },
  { 'sainnhe/everforest', lazy = false, priority = 1000 },
  { 'shaunsingh/nord.nvim', lazy = false, priority = 1000 },

  {
    'config-theme',
    virtual = true,
    lazy = false,
    config = function()
      local themes = {
        ['tokyo-night'] = 'tokyonight-night',
        ['rose-pine'] = 'rose-pine',
        ['catppuccin-mocha'] = 'catppuccin-mocha',
        ['gruvbox'] = 'gruvbox',
        ['everforest'] = 'everforest',
        ['nord'] = 'nord',
      }

      local final_theme = themes[theme_name] or theme_name

      local ok, err = pcall(vim.cmd.colorscheme, final_theme)
      if not ok then
        vim.cmd.colorscheme 'rose-pine'
      end
    end,
  },
}
