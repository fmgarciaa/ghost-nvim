-- This file defines a custom Lualine component to display the status of active
-- Language Server Protocol (LSP) clients for the current buffer.

-- Create a module table to hold the component's functions.
local M = {}

-- Function that Lualine will call to get the text/icon for the LSP status component.
function M.status()
  local buf_ft = vim.bo.filetype -- Get the filetype of the current buffer.
  -- Get a list of all active LSP clients in Neovim.
  -- Each client object contains information like its name and configured filetypes.
  local clients = vim.lsp.get_clients()
  local names = {} -- Initialize an empty table to store the names of relevant LSP clients.

  -- Iterate over the list of active LSP clients.
  for _, client in ipairs(clients) do
    -- Check if the client is configured for the current buffer's filetype.
    if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
      -- Specifically exclude 'null-ls' from the list of displayed LSP servers.
      -- null-ls is often used as a bridge for formatters/linters and might not be
      -- considered a primary "language server" for display purposes here.
      if client.name ~= 'null-ls' then
        table.insert(names, client.name) -- Add the client's name to the list.
      end
    end
  end

  -- Check if any relevant LSP clients were found.
  if next(names) then
    -- If there are active clients, display a "connected" icon (󰌌 - Nerd Font)
    -- followed by a comma-separated list of their names.
    return '󰌌 ' .. table.concat(names, ', ')
  else
    -- If no relevant LSP clients are active for the current buffer's filetype,
    -- display a "disconnected" or "inactive" icon (󰌐 - Nerd Font).
    return '󰌐 '
  end
end

-- Return the module table. Lualine will be configured to call M.status
-- when this component is used in a section.
return M

-- Example of how this might be used in lualine.setup sections:
-- sections = {
--   lualine_y = { require('plugins.appearance.lualine_comps.lsp_status').status, ... }
-- }
-- The current lualine config seems to use this structure: `lsp_status` (which is `M.status`).
