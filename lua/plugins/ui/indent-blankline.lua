return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "┆",
			smart_indent_cap = true,
			-- Usa los nombres recomendados por la documentación
			highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			},
		},
		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			show_exact_scope = false,
			highlight = { "RainbowBlue" },
		},
		whitespace = {
			remove_blankline_trail = true,
		},
		exclude = {
			filetypes = {
				"help",
				"startify",
				"dashboard",
				"packer",
				"neogitstatus",
				"NvimTree",
				"Trouble",
				"lazy",
				"mason",
				"terminal",
			},
			buftypes = {
				"terminal",
				"nofile",
				"quickfix",
				"prompt",
			},
		},
	},
	config = function(_, opts)
		local hooks = require("ibl.hooks")

		-- Registra los grupos de highlight de forma segura al cargar o cambiar de colorscheme
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)

		-- Requiere ibl después de definir los hooks para evitar errores de carga
		require("ibl").setup(opts)

		-- Requiere este hook extra para que funcione correctamente con scope y Treesitter
		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
