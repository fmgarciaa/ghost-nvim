-- lua/components/lsp_status.lua
-- This module exports a function you can plug directly into lualine's sections.
local M = {}

--- Return a string with active LSP clients for the current buffer
-- Skips null-ls and only shows clients that support the current filetype.
function M.status()
	local buf_ft = vim.bo.filetype
	local clients = vim.lsp.get_clients()
	local names = {}

	for _, client in ipairs(clients) do
		-- Only include clients that support this filetype
		if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
			-- Skip null-ls
			if client.name ~= "null-ls" then
				table.insert(names, client.name)
			end
		end
	end

	if next(names) then
		-- "󰌌 " is a nice icon for active LSP
		return "󰌌 " .. table.concat(names, ", ")
	else
		-- Show this when no LSP is attached
		return "󰌐 "
	end
end

return M
