-- File: lua/plugins/ui/lualine_comps/docker.lua
local M = {}

function M.is_running()
	local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
	local path = is_win and [[\\.\pipe\docker_engine]] or "/var/run/docker.sock"
	local st = vim.loop.fs_stat(path)
	return st and (is_win or st.type == "socket")
end

function M.component()
	return M.is_running() and " " or " "
end

function M.color()
	if M.is_running() then
		return { fg = "#0D4715", gui = "bold" }
	else
		return { fg = "#85193C", gui = "bold" }
	end
end

return {
	M.component,    -- posición [1]: la función que Lualine va a llamar
	color = M.color, -- callback para el color dinámico
}
