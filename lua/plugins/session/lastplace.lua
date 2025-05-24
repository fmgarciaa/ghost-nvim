-- This file configures the farmergreg/vim-lastplace plugin, which automatically
-- restores the cursor position to where it was when a file was last closed.

-- Return the plugin specification for lazy.nvim.
return {
  'farmergreg/vim-lastplace', -- The plugin's repository name.
  opts = {}, -- Plugin-specific options passed to a Lua setup function (if any).
             -- For vimscript plugins like vim-lastplace, configuration is typically
             -- done via global Vim variables (g:...). This empty table indicates
             -- configuration will be handled in the `config` function.
  config = function() -- Function to run after the plugin is loaded.
    -- Configure vim-lastplace using global Vimscript variables.

    -- `g:lastplace_ignore_buftype` specifies a comma-separated list of buffer types
    -- for which the cursor position should not be saved or restored.
    -- 'quickfix': Quickfix window buffers.
    -- 'nofile': Buffers not associated with a file (e.g., scratch buffers).
    -- 'help': Help document buffers.
    vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help'

    -- `g:lastplace_ignore_filetype` specifies a comma-separated list of filetypes
    -- for which the cursor position should not be saved or restored.
    -- Useful for commit message buffers or other special filetypes where
    -- restoring the last position might not be desired.
    vim.g.lastplace_ignore_filetype = 'gitcommit,gitrebase,svn,hgcommit'

    -- `g:lastplace_open_folds` controls whether folds should be automatically opened
    -- when restoring the cursor position if the last position was within a fold.
    -- 1 means true: open folds to reveal the last cursor position.
    -- 0 means false: keep folds closed, position might be restored within a closed fold.
    vim.g.lastplace_open_folds = 1

    -- Other potential vim-lastplace options (not used here):
    -- vim.g.lastplace_enabled = 1 -- (default) Enable/disable the plugin.
    -- vim.g.lastplace_max_buflines = 0 -- (default is 0, no limit) Max buffer lines to consider.
  end,
}
