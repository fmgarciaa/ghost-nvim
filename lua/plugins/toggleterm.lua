return {
	"akinsho/toggleterm.nvim",
	opts = {},
	config = function()
		require("toggleterm").setup({
			shade_terminals = false,
			highlights = {
				Normal = {
					guibg = "#282c34",
				},
				NormalFloat = {
					guibg = "#282c34",
				},
			},
		})
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
		vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts)
	end,
}
