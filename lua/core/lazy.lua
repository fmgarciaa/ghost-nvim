-- Define the installation path for lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
-- Clone lazy.nvim if it is not already installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end
-- Add lazy.nvim to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim with plugin specifications and configuration
require('lazy').setup(
  -- Plugin imports from categorized files
  {
    { import = 'plugins' },
    { import = 'plugins.lsp' },
    { import = 'plugins.themes' },
    { import = 'plugins.ai' },
    { import = 'plugins.git' },
    { import = 'plugins.search' },
    { import = 'plugins.terminal' },
    { import = 'plugins.session' },
    { import = 'plugins.coding' },
    { import = 'plugins.appearance' },
  },
  -- Lazy.nvim global configuration options
  {
    change_detection = {
      notify = false, -- Do not show a message when config files change
    },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'matchit',
          'matchparen',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
    ui = {
      border = 'rounded', -- Use rounded borders for lazy UI windows
      wrap = true, -- Wrap long lines in plugin lists
      title = ' Plugins', -- Title displayed in the lazy UI window
    },
  }
)
