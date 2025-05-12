return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
		},
		messages = {
			enabled = true,
			view = "notify",
			view_error = "notify",
			view_warn = "notify",
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = "rounded",
		},
	},
	config = function(_, opts)
		require("noice").setup(opts)

		-- More robust key mappings with error handling
		vim.keymap.set("n", "<leader>nl", function()
			local ok, msg = pcall(require("noice").cmd, "last")
			if not ok then
				vim.notify("Noice: " .. msg, vim.log.levels.WARN)
			end
		end, { desc = "Show last message" })

		vim.keymap.set("n", "<leader>nh", function()
			require("noice").cmd("history")
		end, { desc = "Show message history" })

		vim.keymap.set("n", "<leader>nd", function()
			require("noice").cmd("dismiss")
		end, { desc = "Dismiss notifications" })
	end,
}
