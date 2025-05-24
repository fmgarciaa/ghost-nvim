-- This file sets various Neovim options to customize its behavior.
-- Options control aspects like appearance, editing behavior, and system interaction.

-- Line numbers
vim.wo.number = true -- Show line numbers in the gutter. (wo is for window-local options)
vim.o.relativenumber = true -- Show relative line numbers (current line is 0, others are relative to it). (o is for global options)

-- Clipboard
vim.o.clipboard = 'unnamedplus' -- Use the system clipboard for yank and paste operations.
                               -- 'unnamedplus' specifically targets the '+' register, common for system clipboard.

-- Text wrapping and display
vim.o.wrap = false -- Disable line wrapping. Long lines will extend off-screen.
vim.o.linebreak = true -- If 'wrap' is true, break lines at word boundaries instead of mid-word.
vim.o.mouse = 'a' -- Enable mouse support in all modes (Normal, Visual, Insert, Command-line).
vim.api.nvim_set_option('mouse', 'a') -- Alternative way to set mouse option, ensuring it's applied.

-- Indentation
vim.o.autoindent = true -- Automatically indent new lines based on the previous line.
vim.o.ignorecase = true -- Ignore case when searching, unless the search pattern contains uppercase characters.
vim.o.smartcase = true -- If 'ignorecase' is true, automatically switch to case-sensitive search if the pattern contains uppercase.
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.o.tabstop = 4 -- Number of spaces a <Tab> character represents in the buffer.
vim.o.softtabstop = 4 -- Number of spaces a <Tab> counts for while performing editing operations like <Tab> or <BS>.
vim.o.expandtab = true -- Insert spaces when <Tab> is pressed, instead of a literal tab character.
vim.o.smartindent = true -- Enable smart autoindenting for C-like languages.

-- Scrolling behavior
vim.o.scrolloff = 4 -- Keep at least 4 lines visible above and below the cursor when scrolling.
vim.o.sidescrolloff = 8 -- Keep at least 8 columns visible to the left and right of the cursor if 'wrap' is false.

-- Cursor and highlighting
vim.o.cursorline = false -- Disable highlighting of the current line.
vim.o.hlsearch = false -- Disable highlighting of all search matches. Matches are still navigated.

-- Window splitting
vim.o.splitbelow = true -- When splitting horizontally, the new window appears below the current one.
vim.o.splitright = true -- When splitting vertically, the new window appears to the right of the current one.

-- User interface and messages
vim.o.showmode = false -- Don't show the current mode (e.g., -- INSERT --) in the command line.
vim.opt.termguicolors = true -- Enable true color support in the terminal, allowing for more accurate colorschemes.
vim.o.whichwrap = 'bs<>[]hl' -- Allow specified keys (backspace, space, arrows, home, end) to move to the previous/next line.
vim.o.numberwidth = 4 -- Set the width of the number column.
vim.o.showtabline = 2 -- Always show the tabline, even if there's only one tab. (0=never, 1=if more than one, 2=always)
vim.o.pumheight = 10 -- Maximum number of items to show in the popup menu (for completions).
vim.o.conceallevel = 0 -- Show concealed text (e.g., markdown syntax) by default. (0=show, 1-3=conceal more)
vim.wo.signcolumn = 'yes' -- Always show the signcolumn (used for diagnostics, git signs, etc.). 'auto' would hide it if empty.
vim.o.cmdheight = 1 -- Set the height of the command-line area to 1 line.
vim.o.updatetime = 250 -- Time in milliseconds until CursorHold and CursorHoldI events are triggered, and swap file updates.
vim.o.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.

-- File handling and backups
vim.o.swapfile = false -- Disable creation of swap files (temporary files used for recovery).
vim.o.backup = false -- Disable creation of backup files (copies of files before saving).
vim.o.writebackup = false -- Disable making a backup before overwriting a file.
vim.o.undofile = true -- Enable persistent undo history (saves undo information to a file).

-- Completion behavior
vim.o.completeopt = 'menuone,noselect' -- Configure completion options:
                                     -- 'menuone': Show the popup menu even if there's only one match.
                                     -- 'noselect': Don't automatically select the first match.

-- Message verbosity and keyword handling
vim.opt.shortmess:append 'c' -- Don't show "match 1 of N" messages during completion.
vim.opt.iskeyword:append '-' -- Treat hyphenated words as single words for navigation and search.
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- Control auto-formatting of comments.
                                              -- Removes options for auto-wrapping comments with 'textwidth',
                                              -- on <Enter> in Insert mode, or on 'o'/'O' in Normal mode.

-- Runtime path modification
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- Remove Vim's default user plugin directory to avoid conflicts
                                                    -- if both Vim and Neovim are used.

-- Appearance of special characters
vim.opt.fillchars = { eob = ' ' } -- Set the character for "end of buffer" lines to a space.
                                  -- This prevents the default '~' from showing on empty lines at the end of the buffer.
vim.o.breakindent = true -- When 'wrap' is on, maintain the same indentation level for wrapped lines.
vim.o.fileencoding = 'utf-8' -- Set the default file encoding to UTF-8.
vim.o.backspace = 'indent,eol,start' -- Allow backspace to delete autoindent, end-of-line characters, and start of insert.
