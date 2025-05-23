-- lua/components/lsp_status.lua
-- This module exports a function you can plug directly into lualine's sections.
local M = {}

function M.status()
  local buf_ft = vim.bo.filetype
  local clients = vim.lsp.get_clients()
  local names = {}

  for _, client in ipairs(clients) do
    if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
      -- Skip null-ls
      if client.name ~= 'null-ls' then
        table.insert(names, client.name)
      end
    end
  end

  if next(names) then
    return '󰌌 ' .. table.concat(names, ', ')
  else
    return '󰌐 '
  end
end

return M
