-- This file configures the folke/persistence.nvim plugin, which automatically
-- saves and restores Neovim sessions, allowing you to resume your work
-- (open buffers, window layouts, current directory, etc.) across restarts.

-- Return the plugin specification for lazy.nvim.
return {
  'folke/persistence.nvim', -- The plugin's repository name.
  event = 'BufReadPre', -- Load the plugin early, before a buffer is read.
                        -- This allows it to potentially load a session for the current directory
                        -- or handle session saving/loading logic early in the Neovim lifecycle.
                        -- 'VimEnter' could also be an option if session loading is desired only after Neovim fully starts.
  config = function() -- Function to run after the plugin is loaded.
    require('persistence').setup {
      -- `dir` specifies the directory where session files will be saved.
      -- `vim.fn.stdpath 'state'` typically resolves to `~/.local/state/nvim` (on Linux).
      -- So, sessions will be stored in `~/.local/state/nvim/sessions/`.
      dir = vim.fn.stdpath 'state' .. '/sessions/',

      -- `options` is a list of what aspects of the Neovim session to save.
      -- 'buffers': Save the list of open buffers.
      -- 'curdir': Save the current working directory.
      -- 'tabpages': Save the layout of tab pages and their windows.
      -- 'winsize': Save the Neovim window size.
      -- Other options might include 'globals', 'folds', 'localoptions', etc.
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' },

      -- `pre_save = nil` -- A function to run before saving a session.
      -- `post_save = nil` -- A function to run after saving a session.
      -- `before_load = nil` -- A function to run before loading a session.
      -- `after_load = nil` -- A function to run after loading a session.
      -- `autosave = true` -- (Default) Automatically save the session on Neovim exit.
      -- `autoload = true` -- (Default) Automatically load the session for the current directory if it exists.
    }

    -- Keymaps for interacting with persistence.nvim.
    local keymap = vim.keymap.set -- Shorthand for vim.keymap.set.

    -- Map <leader>ps to load (restore) the session for the current directory.
    keymap('n', '<leader>ps', function()
      require('persistence').load()
    end, { desc = 'Restore session for the current directory' })

    -- Map <leader>pS to select a specific session to load from a list (if multiple sessions exist).
    keymap('n', '<leader>pS', function()
      require('persistence').select()
    end, { desc = 'Select a session to load' })

    -- Map <leader>pl to load the last saved session.
    keymap('n', '<leader>pl', function()
      require('persistence').load { last = true }
    end, { desc = 'load the last session' })

    -- Map <leader>pd to stop persistence for the current session.
    -- This means the current state (buffers, etc.) will not be saved on exit for this session.
    keymap('n', '<leader>pd', function()
      require('persistence').stop()
    end, { desc = "Don't save the current session" })
  end,
}
