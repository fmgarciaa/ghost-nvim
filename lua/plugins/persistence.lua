return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	config = function()
		require("persistence").setup({
			dir = vim.fn.stdpath("state") .. "/sessions/",
			options = { "buffers", "curdir", "tabpages", "winsize" },
		})
	end,
}
