-- This file defines a custom Lualine component to display the current operating system.
-- It uses Neovim's libuv integration to get OS information and prepends a Nerd Font icon.

-- Create a module table to hold the component's functions.
local M = {}

-- Function that Lualine will call to get the text/icon for the OS status component.
function M.status()
  -- Get operating system information using vim.loop.os_uname(), which provides
  -- details similar to the 'uname' command via libuv.
  -- We are interested in 'sysname' (e.g., "Linux", "Darwin", "Windows_NT").
  local sys = vim.loop.os_uname().sysname

  -- Match common system names and return a string with a corresponding Nerd Font icon.
  if sys == 'Linux' then
    return ' Linux' -- Linux icon (Tux) and text.
  elseif sys == 'Darwin' then
    return ' macOS' -- Apple icon and text for macOS.
  elseif sys:match 'Windows' then -- Check if 'sysname' contains "Windows".
    return ' Windows' -- Windows icon and text.
  else
    -- Fallback for unknown or other operating systems.
    return ' Unknown' -- Question mark icon and "Unknown" text.
  end
end

-- Return the module table. Lualine will typically be configured to call M.status
-- when this component is used in a section.
return M

-- Example of how this might be used in lualine.setup sections:
-- sections = {
--   lualine_x = { require('plugins.appearance.lualine_comps.get_os').status, ... }
-- }
-- Or, if the component itself is returned as a function:
-- sections = {
--   lualine_x = { require('plugins.appearance.lualine_comps.get_os'), ... }
-- }
-- The current lualine config seems to use the former: `get_os` (which is `M.status`).
