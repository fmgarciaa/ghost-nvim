-- This file defines a custom Lualine component to display Docker status.
-- It checks if the Docker daemon/socket is accessible and shows an icon accordingly.

-- Create a module table to hold the component's functions.
local M = {}

-- Function to check if the Docker service is running or accessible.
-- It checks for the Docker socket on Unix-like systems and a named pipe on Windows.
function M.is_running()
  local is_win = vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 -- Check if the OS is Windows.
  -- Define the path to the Docker communication interface based on the OS.
  local path = is_win and [[\\.\pipe\docker_engine]] or '/var/run/docker.sock'
  -- Get file system statistics for the path.
  -- vim.loop.fs_stat is Neovim's way to interact with libuv's filesystem functions.
  local st = vim.loop.fs_stat(path)
  -- Check if the path exists (st is not nil) and if it's a socket (on non-Windows)
  -- or just exists (on Windows, as named pipes are checked differently).
  return st and (is_win or st.type == 'socket')
end

-- Function that Lualine will call to get the text/icon for the component.
function M.component()
  -- Returns a Docker icon. The icon itself is the same regardless of status in this implementation,
  -- but the color will change based on the status.
  -- The icon '' is a Nerd Font icon for Docker.
  return M.is_running() and ' ' or ' ' -- Shows Docker icon if running, or same icon if not (color indicates status).
end

-- Function that Lualine will call to get the color for the component.
-- This allows for dynamic coloring based on Docker's status.
function M.color()
  if M.is_running() then
    -- If Docker is running, set foreground color to dark green and bold style.
    return { fg = '#0D4715', gui = 'bold' }
  else
    -- If Docker is not running, set foreground color to dark red and bold style.
    return { fg = '#85193C', gui = 'bold' }
  end
end

-- Return the component structure that Lualine expects.
-- This typically involves providing the function to get the component's text
-- and optionally functions or tables for colors, icons, etc.
return {
  M.component, -- The first element is the function Lualine calls to get the component's text.
  color = M.color, -- Provides a callback function for dynamic coloring.
  -- Other Lualine component options could be added here, e.g.:
  -- icon = '', -- A static icon (though M.component already returns one)
  -- separator = '',
  -- padding = 0,
}
