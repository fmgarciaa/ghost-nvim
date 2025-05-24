-- This file defines custom Neovim commands.

-- Creates a custom Neovim command `:ReloadConfig` to reload the user's configuration.
-- This command sources the user's init.vim or init.lua file (typically $MYVIMRC)
-- and prints a confirmation message to the command line.
vim.api.nvim_create_user_command(
  'ReloadConfig', -- The name of the command to create.
  function()
    vim.cmd 'source $MYVIMRC' -- Executes the ':source $MYVIMRC' command to reload the config.
    print 'Config reloaded!' -- Prints a confirmation message.
  end,
  {} -- Optional attributes for the command (empty in this case).
)
