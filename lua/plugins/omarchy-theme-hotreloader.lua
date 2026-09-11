local omarchy = require 'config.omarchy'

if not omarchy.enabled then
  return {}
end

local function plugin_name(spec)
  if spec.name then
    return spec.name
  end

  return spec[1] and spec[1]:match '/([^/]+)$' or nil
end

local function read_theme()
  package.loaded['plugins.theme'] = nil

  local ok, theme_spec = pcall(require, 'plugins.theme')
  if not ok then
    return nil, nil, theme_spec
  end

  local theme_plugin
  local colorscheme

  for _, spec in ipairs(theme_spec) do
    if spec[1] == 'LazyVim/LazyVim' then
      if type(spec.opts) == 'table' then
        colorscheme = spec.opts.colorscheme
      end
    elseif spec[1] and not theme_plugin then
      theme_plugin = plugin_name(spec)
    end
  end

  if not colorscheme then
    return nil, nil, 'the Omarchy theme does not declare a colorscheme'
  end

  return theme_plugin, colorscheme
end

local function apply_theme()
  local theme_plugin_name, colorscheme, err = read_theme()
  if err then
    vim.notify('Could not load the Omarchy theme: ' .. err, vim.log.levels.ERROR)
    return
  end

  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' == 1 then
    vim.cmd 'syntax reset'
  end
  vim.o.background = 'dark'

  local loader = require 'lazy.core.loader'
  local theme_plugin = theme_plugin_name and require('lazy.core.config').plugins[theme_plugin_name]

  if theme_plugin and theme_plugin._.loaded then
    loader.reload(theme_plugin)
  else
    loader.colorscheme(colorscheme)
  end

  local ok, colorscheme_err = pcall(vim.cmd.colorscheme, colorscheme)
  if not ok then
    vim.notify('Could not apply Omarchy colorscheme ' .. colorscheme .. ': ' .. colorscheme_err, vim.log.levels.ERROR)
    return
  end

  vim.cmd 'redraw!'
end

return {
  {
    name = 'omarchy-theme-hotreloader',
    dir = vim.fn.stdpath 'config',
    lazy = false,
    priority = 1000,
    config = function()
      local group = vim.api.nvim_create_augroup('OmarchyThemeHotreload', { clear = true })

      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'LazyReload',
        callback = function()
          vim.schedule(apply_theme)
        end,
      })

      -- LazyVim normally applies the initial scheme. This config does it itself.
      vim.schedule(apply_theme)
    end,
  },
}
