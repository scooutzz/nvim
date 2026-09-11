local M = {
  enabled = false,
  theme_file = nil,
}

local uv = vim.uv or vim.loop
local state_home = vim.fn.fnamemodify(vim.fn.stdpath 'state', ':h')
local config_home = vim.fn.fnamemodify(vim.fn.stdpath 'config', ':h')
local candidates = {
  state_home .. '/omarchy/current/theme/neovim.lua',
  config_home .. '/omarchy/current/theme/neovim.lua', -- Omarchy 3.x
}

for _, path in ipairs(candidates) do
  if vim.fn.filereadable(path) == 1 then
    M.enabled = true
    M.theme_file = path
    break
  end
end

if M.enabled then
  local theme_link = vim.fn.stdpath 'config' .. '/lua/plugins/theme.lua'
  local link_stat = uv.fs_lstat(theme_link)
  local current_target = link_stat and link_stat.type == 'link' and uv.fs_readlink(theme_link) or nil

  if current_target ~= M.theme_file then
    if not link_stat or link_stat.type == 'link' then
      if link_stat then
        uv.fs_unlink(theme_link)
      end

      local ok, err = uv.fs_symlink(M.theme_file, theme_link)
      if not ok then
        vim.schedule(function()
          vim.notify('Could not link the Omarchy theme: ' .. err, vim.log.levels.WARN)
        end)
      end
    else
      vim.schedule(function()
        vim.notify('Omarchy theme integration skipped: ' .. theme_link .. ' is not a symlink', vim.log.levels.WARN)
      end)
    end
  end
end

return M
