-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
local map = vim.api.nvim_set_keymap

-- For conciseness
local opts = { noremap = true, silent = true }

-- save and exist
vim.keymap.set("n", "<leader>w", ":w<CR>", opts)        -- save file
vim.keymap.set("n", "<leader>W", ":w<CR>", opts)        -- save file
map("i", "<leader>w", "<Esc>:w<CR>", opts)              -- save file in insert mode
map("i", "<leader>w", "<Esc>:W<CR>", opts)              -- save file in insert mode
vim.keymap.set("v", "<leader>w", "<Esc>:w<CR>gv", opts) -- save file in visual mode
vim.keymap.set("n", "<leader>x", ":wq<CR>", opts)       -- save and exit file
vim.keymap.set("n", "<leader>c", ":bd<CR>", opts)       -- close file
vim.keymap.set("n", "<leader>q", ":qa<CR>", opts)       -- quit all files
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", opts)      -- force quit all files

-- save file
-- vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
--- quit file
-- vim.keymap.set("n", "<C-q>", "<cmd> qa <CR>", opts)
-- vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<M-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<M-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<M-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<M-Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts)   -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts)      -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts)      -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts)     -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window
vim.keymap.set("n", "<leader>l", "<C-w>w", { noremap = true, silent = true })

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts)   -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts)     --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts)     --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
--vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
--vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
--vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
--vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
--
-- Session management (persistence.nvim)
vim.keymap.set("n", "<leader>qs", function()
	require("persistence").load()
end, { noremap = true, silent = true, desc = "Restore session for cwd" })

vim.keymap.set("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end, { noremap = true, silent = true, desc = "Restore last session" })

vim.keymap.set("n", "<leader>qd", function()
	require("persistence").stop()
end, { noremap = true, silent = true, desc = "Don't save session on exit" })

-- Trouble keymaps with <leader>t prefix
vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", opts)              -- Toggle main Trouble
vim.keymap.set("n", "<leader>tw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts) -- Workspace
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", opts)                   -- Quickfix
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble loclist toggle<cr>", opts)                  -- Loclist
vim.keymap.set("n", "<leader>td", "<cmd>TodoTrouble<cr>", opts)                             -- Todo-comments in Trouble
