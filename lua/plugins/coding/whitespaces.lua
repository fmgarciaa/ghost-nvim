-- This file configures the ntpeters/vim-better-whitespace plugin.
-- This plugin helps to highlight and manage trailing whitespace in files.

-- Return the plugin specification for lazy.nvim.
return {
  'ntpeters/vim-better-whitespace', -- The plugin's repository name.
  opts = {}, -- Plugin-specific options. In this case, it's empty, meaning
             -- the configuration is handled by global Vim variables in the config function.
             -- If the plugin supported setup via a Lua function, options would go here.
  config = function() -- Function to run after the plugin is loaded.
    -- Enable the plugin's functionality on startup.
    -- This makes vim-better-whitespace active for all buffers unless blacklisted.
    vim.g.better_whitespace_enabled = 1 -- 1 means true.

    -- Configure the plugin to automatically strip trailing whitespace when a file is saved.
    vim.g.strip_whitespace_on_save = 1 -- 1 means true.

    -- Disable the confirmation prompt that asks before stripping whitespace.
    -- When set to 0 (false), stripping happens silently on save.
    -- If it were 1 (true), you'd be prompted each time.
    vim.g.strip_whitespace_confirm = 0

    -- Other potential global configurations for vim-better-whitespace (not used here):
    -- vim.g.better_whitespace_filetypes_blacklist = { 'markdown', 'log' } -- Disable for specific filetypes.
    -- vim.g.better_whitespace_highlight_color = 'red' -- Change highlight color for trailing whitespace.
    -- vim.g.better_whitespace_operator = '_s' -- Custom operator for stripping whitespace.

    -- The plugin also provides commands like :StripWhitespace that can be used manually.
  end,
}
