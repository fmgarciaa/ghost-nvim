-- Advanced search and replace in multiple files
return {
	"dyng/ctrlsf.vim",
	opts = {}, -- No extensive configuration needed
	config = function()
		-- Set ripgrep (rg) as the default search program for better performance
		vim.g.ctrlsf_ackprg = "rg --vimgrep --hidden"
		-- Set search root to the project directory
		vim.g.ctrlsf_default_root = "project"
		-- Auto close search window after jumping to a result
		vim.g.ctrlsf_auto_close = 1
		-- Open search results in a vertical split
		vim.g.ctrlsf_position = "left"

		-- Keymaps for CtrlSF
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>s;", ":CtrlSF ", opts)        -- Start a search
		vim.keymap.set("n", "<leader>su", ":CtrlSFCwordExec ", opts) -- Search for word under cursor
		vim.keymap.set("n", "<leader>sc", ":CtrlSFClose<CR>", opts) -- Close search window
	end,
}
