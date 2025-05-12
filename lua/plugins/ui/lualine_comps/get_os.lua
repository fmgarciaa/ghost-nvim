-- lua/components/os_status.lua
-- Exports a function that returns current OS name (with icon) for lualine
local M = {}

function M.status()
	-- get OS name from libuv
	local sys = vim.loop.os_uname().sysname

	-- match common names and prepend a Nerd Font icon
	if sys == "Linux" then
		return " Linux"
	elseif sys == "Darwin" then
		return " macOS"
	elseif sys:match("Windows") then
		return " Windows"
	else
		-- fallback for unknown systems
		return " Unknown"
	end
end

return M
