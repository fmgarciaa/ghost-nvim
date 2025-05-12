-- Lualine configuration with the 'copilot' component
local copilot = {
	"copilot",
	symbols = {
		status = {
			icons = {
				enabled = " ", -- Icon when Copilot is enabled
				sleep = " ", -- Icon when auto-trigger is disabled
				disabled = " ", -- Icon when Copilot is disabled
				warning = " ", -- Icon for warning states
				unknown = " ", -- Icon for unknown states
			},
			hl = {
				enabled = "#0D4715", -- Green color for the enabled state
				sleep = "#0D4715", -- FIXME: the color for auto-trigger disabled
				disabled = "#6272A4", -- Dark blue for the disabled state
				warning = "#FFB86C", -- Orange for warning states
				unknown = "#85193C", -- Red for unknown states
			},
		},
		spinners = "dots",       -- Uses the predefined "dots" spinner
		spinner_color = "#6272A4", -- Color of the spinner
	},
	show_colors = true,        -- Show colors in the status
	show_loading = true,       -- Show loading status
}

return copilot
