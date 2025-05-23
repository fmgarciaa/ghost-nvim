-- Creates a custom Neovim command `:ReloadConfig` to reload the user's configuration.
-- This command sources the user's init.vim or init.lua file and prints a confirmation message.
vim.api.nvim_create_user_command('ReloadConfig', function()
  vim.cmd 'source $MYVIMRC'
  print 'Config reloaded!'
end, {})
