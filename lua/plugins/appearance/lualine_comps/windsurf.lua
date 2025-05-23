-- File: plugins/ui/lualine_comps/codeium.lua
local M = {}

local function is_codeium_available()
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    return false
  end

  for _, source in ipairs(cmp.core.sources) do
    if source.name == 'codeium' and source:is_available() then
      return true
    end
  end
  return false
end

function M.component()
  return is_codeium_available() and '' or '󱜟'
end

function M.color()
  if is_codeium_available() then
    return { fg = '#0D4715', gui = 'bold' } -- verde oscuro
  else
    return { fg = '#85193C', gui = 'bold' } -- rojo oscuro
  end
end

return {
  M.component,
  color = M.color,
}
