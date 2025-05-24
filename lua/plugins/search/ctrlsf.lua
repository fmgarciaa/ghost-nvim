-- This file configures the dyng/ctrlsf.vim plugin, which provides an interface
-- similar to CtrlP or Telescope but specifically for searching and replacing
-- text in multiple files, often using ripgrep (rg) as a backend.

-- Return the plugin specification for lazy.nvim.
return {
  'dyng/ctrlsf.vim', -- The plugin's repository name.
  opts = {}, -- Plugin-specific options passed to a Lua setup function (if the plugin supports it).
             -- For vimscript plugins like ctrlsf.vim, configuration is typically done
             -- via global Vim variables (g:...). This `opts` table is empty,
             -- indicating configuration will be handled in the `config` function.
  config = function() -- Function to run after the plugin is loaded.
    -- Configure CtrlSF using global Vimscript variables.
    -- These variables control various aspects of CtrlSF's behavior.

    -- `g:ctrlsf_ackprg` specifies the command-line program to use for searching.
    -- 'rg --vimgrep --hidden' uses ripgrep (rg) with vimgrep output format
    -- and includes hidden files in searches.
    vim.g.ctrlsf_ackprg = 'rg --vimgrep --hidden'

    -- `g:ctrlsf_default_root` determines how CtrlSF determines the root directory for searches.
    -- 'project' usually means it tries to find the project root (e.g., Git repository root).
    -- Other options might include 'cwd' (current working directory).
    vim.g.ctrlsf_default_root = 'project'

    -- `g:ctrlsf_case_sensitive` controls case sensitivity of searches.
    -- 'smart' means case-insensitive unless the search pattern contains uppercase letters.
    vim.g.ctrlsf_case_sensitive = 'smart'

    -- `g:ctrlsf_auto_close` determines if the CtrlSF window closes automatically after an action.
    -- 1 means true; it will auto-close after opening a file or applying a replace.
    vim.g.ctrlsf_auto_close = 1

    -- `g:ctrlsf_position` sets the position of the CtrlSF results window.
    -- 'left' means it will open as a vertical split on the left.
    -- Other options: 'right', 'bottom', 'top'.
    vim.g.ctrlsf_position = 'left'

    -- `g:ctrlsf_winsize` sets the size of the CtrlSF results window.
    -- '35%' means it will occupy 35% of the available width (for 'left'/'right' position)
    -- or height (for 'top'/'bottom' position).
    vim.g.ctrlsf_winsize = '35%'

    -- `g:ctrlsf_context` specifies the number of context lines to show around matches.
    -- '-C 3' means 3 lines of context above and below each match.
    vim.g.ctrlsf_context = '-C 3'

    -- `g:ctrlsf_ignore_dir` is a list of directory names to ignore during searches.
    vim.g.ctrlsf_ignore_dir = {
      'node_modules',
      '.git',
      'dist',
      '__pycache__',
      '.mypy_cache',
      '.pytest_cache',
      '.venv',
      'env',
      'venv',
    }

    -- Keymaps for CtrlSF.
    local keymap = vim.keymap.set
    -- Map <C-f>f in Normal and Insert modes to start a CtrlSF search.
    -- The trailing space after ':CtrlSF ' allows typing the search query directly.
    keymap({ 'n', 'i' }, '<C-f>f', ':CtrlSF ', { noremap = true, silent = true, desc = 'Start a search' })
    -- Map <C-f>c in Normal mode to close the CtrlSF window.
    keymap('n', '<C-f>c', ':CtrlSFClose<CR>', { noremap = true, silent = true, desc = 'Close search window' })

    -- CtrlSF also provides commands like :CtrlSFOpen, :CtrlSFRename, :CtrlSFReplace, etc.
  end,
}
