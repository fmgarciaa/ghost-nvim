-- Neovim Keymap Configuration: Efficient & Ergonomic
-- Set leader and localleader to Space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Common mapping options
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save & Quit
keymap({ 'n', 'i' }, '<C-s>', "<Esc><cmd>w<CR><cmd>echo 'File Saved! 💾'<CR>", opts) -- save file
keymap('n', '<C-q>', '<cmd> q <CR>', opts) -- quit file
keymap('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts) -- save file without auto-formatting

-- Select all (ggVG)
keymap('n', '<C-a>', 'ggVG', opts) -- <C-a>: select entire buffer

-- Line boundary shortcuts
keymap('n', 'H', 'g^', opts) -- H: first non-blank
keymap('n', 'L', 'g$', opts) -- L: end of line

-- delete single character without copying into register
keymap('n', 'x', '"_x', opts)

-- Vertical scroll and center
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
keymap('n', '<M-Up>', ':resize -2<CR>', opts)
keymap('n', '<M-Down>', ':resize +2<CR>', opts)
keymap('n', '<M-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<M-S-Right>', ':vertical resize +2<CR>', opts)

-- Buffers
keymap('n', '<Tab>', ':bnext<CR>', opts)
keymap('n', '<S-Tab>', ':bprevious<CR>', opts)
keymap('n', '<leader>x', ':bdelete!<CR>', { desc = 'Close Buffer' }) -- close buffer
keymap('n', '<leader>b', '<cmd> enew <CR>', { desc = 'New Buffer' }) -- new buffer

-- Window management
keymap('n', '<leader>v', '<C-w>v', { desc = 'Split Window vertically' }) -- split window vertically
keymap('n', '<leader>h', '<C-w>s', { desc = 'Split Window horizontally' }) -- split window horizontally
keymap('n', '<leader>se', '<C-w>=', { desc = 'Make split windows iqual width & height' }) -- make split windows equal width & height
keymap('n', '<leader>xs', ':close<CR>', { desc = 'Close current split window' }) -- close current split window
keymap('n', '<leader>l', '<C-w>w', { desc = 'Switch to next split window' }) -- switch to next split window

-- Navigate between splits
keymap('n', '<C-k>', ':wincmd k<CR>', opts)
keymap('n', '<C-j>', ':wincmd j<CR>', opts)
keymap('n', '<C-h>', ':wincmd h<CR>', opts)
keymap('n', '<C-l>', ':wincmd l<CR>', opts)

-- Toggle line wrapping
keymap('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Keep last yanked when pasting
keymap('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Others keymaping in:
-- /lua/plugins/lsp/cmp.lua
-- /lua/plugins/lsp/lsp.lua
-- /lua/plugins/ctrlsf.lua
-- /lua/plugins/gitsigns.lua
-- /lua/plugins/lazygit.lua
-- /lua/plugins/neotree.lua
-- /lua/plugins/telescope.lua
-- /lua/plugins/toggleterm.lua
-- /lua/plugins/trouble.lua
