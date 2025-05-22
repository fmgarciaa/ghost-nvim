-- plugins/ui/lualine_comps/codeium.lua
local M = {}

M.status = function()
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    return ''
  end

  for _, source in ipairs(cmp.core.sources) do
    if source.name == 'codeium' and source:is_available() then
      return ''
    end
  end
  return '󱜟'
end

return M
