-- This file defines custom key mappings for Neovim.
-- Key mappings are shortcuts that allow users to perform actions with fewer keystrokes.

-- Set leader and localleader keys to Space.
-- The leader key is a prefix for many custom shortcuts.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior (which is to move the cursor right)
-- in Normal and Visual modes. This allows '<Space>' to be used as the leader key.
-- '<Nop>' means "no operation".
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Store the vim.keymap.set function in a local variable for brevity.
local keymap = vim.keymap.set
-- Define common options for key mappings.
-- noremap = true: Non-recursive mapping. Prevents the mapping from triggering itself.
-- silent = true: Executes the command silently without displaying it in the command line.
local opts = { noremap = true, silent = true }

-- Key mappings for Save & Quit operations.
-- <C-s> in Normal and Insert modes: Saves the file and echoes a message.
keymap({ 'n', 'i' }, '<C-s>', "<Esc><cmd>w<CR><cmd>echo 'File Saved! 💾'<CR>", opts)
-- <C-q> in Normal mode: Quits the current window.
keymap('n', '<C-q>', '<cmd> q <CR>', opts)
-- <leader>sn in Normal mode: Saves the file without triggering auto-formatting.
keymap('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts) -- save file without auto-formatting

-- Key mapping for selecting all text in the buffer (ggVG).
-- <C-a> in Normal mode: Moves to the first line (gg), starts visual mode (V), then goes to the last line (G).
keymap('n', '<C-a>', 'ggVG', opts)

-- Key mappings for navigating to line boundaries.
-- H in Normal mode: Moves to the first non-blank character of the current line (g^).
keymap('n', 'H', 'g^', opts)
-- L in Normal mode: Moves to the end of the current line (g$).
keymap('n', 'L', 'g$', opts)

-- Key mapping for deleting a single character without copying it into a register.
-- x in Normal mode: Deletes the character under the cursor and sends it to the black hole register ("_).
keymap('n', 'x', '"_x', opts)

-- Key mappings for vertical scrolling while keeping the cursor centered.
-- <C-d> in Normal mode: Scrolls down half a screen and centers the view (zz).
keymap('n', '<C-d>', '<C-d>zz', opts)
-- <C-u> in Normal mode: Scrolls up half a screen and centers the view (zz).
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Key mappings for searching and keeping the current match centered.
-- n in Normal mode: Goes to the next match and centers the view (zzzv).
keymap('n', 'n', 'nzzzv', opts)
-- N in Normal mode: Goes to the previous match and centers the view (zzzv).
keymap('n', 'N', 'Nzzzv', opts)

-- Key mappings for resizing windows using Alt + Arrow keys.
-- <M-Up> (Alt+Up) in Normal mode: Decreases window height by 2 lines.
keymap('n', '<M-Up>', ':resize -2<CR>', opts)
-- <M-Down> (Alt+Down) in Normal mode: Increases window height by 2 lines.
keymap('n', '<M-Down>', ':resize +2<CR>', opts)
-- <M-Left> (Alt+Left) in Normal mode: Decreases window width by 2 columns.
keymap('n', '<M-Left>', ':vertical resize -2<CR>', opts)
-- <M-S-Right> (Alt+Shift+Right) in Normal mode: Increases window width by 2 columns.
keymap('n', '<M-S-Right>', ':vertical resize +2<CR>', opts)

-- Key mappings for managing buffers.
-- <Tab> in Normal mode: Switches to the next buffer.
keymap('n', '<Tab>', ':bnext<CR>', opts)
-- <S-Tab> (Shift+Tab) in Normal mode: Switches to the previous buffer.
keymap('n', '<S-Tab>', ':bprevious<CR>', opts)
-- <leader>x in Normal mode: Closes the current buffer.
keymap('n', '<leader>x', ':bdelete!<CR>', { desc = 'Close Buffer' })
-- <leader>b in Normal mode: Creates a new empty buffer.
keymap('n', '<leader>b', '<cmd> enew <CR>', { desc = 'New Buffer' })

-- Key mappings for window management.
-- <leader>v in Normal mode: Splits the current window vertically.
keymap('n', '<leader>v', '<C-w>v', { desc = 'Split Window vertically' })
-- <leader>h in Normal mode: Splits the current window horizontally.
keymap('n', '<leader>h', '<C-w>s', { desc = 'Split Window horizontally' })
-- <leader>se in Normal mode: Makes all split windows have equal width and height.
keymap('n', '<leader>se', '<C-w>=', { desc = 'Make split windows iqual width & height' })
-- <leader>xs in Normal mode: Closes the current split window.
keymap('n', '<leader>xs', ':close<CR>', { desc = 'Close current split window' })
-- <leader>l in Normal mode: Switches focus to the next split window.
keymap('n', '<leader>l', '<C-w>w', { desc = 'Switch to next split window' })

-- Key mappings for navigating between split windows using Ctrl + H/J/K/L.
-- <C-k> in Normal mode: Moves focus to the window above.
keymap('n', '<C-k>', ':wincmd k<CR>', opts)
-- <C-j> in Normal mode: Moves focus to the window below.
keymap('n', '<C-j>', ':wincmd j<CR>', opts)
-- <C-h> in Normal mode: Moves focus to the window to the left.
keymap('n', '<C-h>', ':wincmd h<CR>', opts)
-- <C-l> in Normal mode: Moves focus to the window to the right.
keymap('n', '<C-l>', ':wincmd l<CR>', opts)

-- Key mapping for toggling line wrapping.
-- <leader>lw in Normal mode: Toggles the 'wrap' option.
keymap('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Key mappings for indenting/unindenting lines in Visual mode while staying in indent mode.
-- < in Visual mode: Unindents the selected lines and reselects them.
keymap('v', '<', '<gv', opts)
-- > in Visual mode: Indents the selected lines and reselects them.
keymap('v', '>', '>gv', opts)

-- Key mapping for pasting without losing the last yanked text.
-- p in Visual mode: Deletes the selected text (into the black hole register) and then pastes.
keymap('v', 'p', '"_dP', opts)

-- Diagnostic keymaps for navigating and viewing diagnostics (e.g., errors, warnings).
-- [d in Normal mode: Goes to the previous diagnostic message.
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- ]d in Normal mode: Goes to the next diagnostic message.
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- <leader>dd in Normal mode: Opens a floating window with the diagnostic message under the cursor.
keymap('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Comments indicating that other key mappings are defined in plugin-specific files.
-- This helps in organizing key mappings and makes it easier to find them.
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
