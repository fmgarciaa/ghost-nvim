-- This file defines a custom Lualine component to display the status of Codeium
-- (which is integrated via the windsurf.nvim plugin, or directly if Codeium has its own LSP/cmp source).
-- It shows an icon indicating whether Codeium's completion source is available.

-- Create a module table to hold the component's functions.
local M = {}

-- Function to check if Codeium's completion source is available and active in nvim-cmp.
local function is_codeium_available()
  -- Attempt to load the 'cmp' (nvim-cmp) module.
  -- pcall (protected call) is used to safely handle cases where nvim-cmp might not be installed or loaded.
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    return false -- If nvim-cmp cannot be loaded, Codeium (as a cmp source) is considered unavailable.
  end

  -- Iterate through the registered completion sources in nvim-cmp.
  -- cmp.core.sources is expected to be a list of source objects.
  for _, source in ipairs(cmp.core.sources) do
    -- Check if the source's name is 'codeium' and if it reports itself as available.
    -- The `source:is_available()` method is a standard part of the nvim-cmp source API.
    if source.name == 'codeium' and source:is_available() then
      return true -- Codeium source found and it's available.
    end
  end
  return false -- Codeium source not found or not available.
end

-- Function that Lualine will call to get the text/icon for the component.
function M.component()
  -- Returns one Nerd Font icon if Codeium is available ( - often related to AI/copilot)
  -- and another if it's not (󱜟 - a disconnected or error-like symbol).
  return is_codeium_available() and '' or '󱜟'
end

-- Function that Lualine will call to get the color for the component.
-- This allows for dynamic coloring based on Codeium's status.
function M.color()
  if is_codeium_available() then
    -- If Codeium is available, set foreground color to dark green and bold style.
    return { fg = '#0D4715', gui = 'bold' } -- Dark green in hex.
  else
    -- If Codeium is not available, set foreground color to dark red and bold style.
    return { fg = '#85193C', gui = 'bold' } -- Dark red in hex.
  end
end

-- Return the component structure that Lualine expects.
return {
  M.component, -- The function Lualine calls to get the component's text/icon.
  color = M.color, -- The function Lualine calls to get the dynamic color.
  -- Other Lualine component options could be added here, e.g.:
  -- icon = '', -- A static icon (though M.component provides a dynamic one)
  -- separator = '',
  -- padding = 0,
}
