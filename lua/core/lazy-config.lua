-- This file configures lazy.nvim, a plugin manager for Neovim.
-- It handles the installation and setup of all other plugins.

-- Define the installation path for lazy.nvim.
-- vim.fn.stdpath('data') returns the standard path for data files (e.g., ~/.local/share/nvim on Linux).
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- Clone lazy.nvim from its GitHub repository if it is not already installed.
-- vim.loop.fs_stat(lazypath) checks if the path exists.
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { -- Executes a system command.
    'git',
    'clone',
    '--filter=blob:none', -- Optimizes cloning by fetching only necessary objects.
    '--branch=stable', -- Clones the stable branch of lazy.nvim.
    'https://github.com/folke/lazy.nvim.git', -- The repository URL.
    lazypath, -- The path where lazy.nvim will be cloned.
  }
end
-- Add lazy.nvim to Neovim's runtime path (rtp).
-- This allows Neovim to find and load lazy.nvim.
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim with plugin specifications and configuration options.
require('lazy').setup(
  -- A list of plugin specifications.
  -- Plugins can be specified directly or imported from other files.
  {
    -- Imports plugin definitions from various categorized files within the 'plugins' directory.
    { import = 'plugins' }, -- General plugins
    { import = 'plugins.lsp' }, -- Language Server Protocol plugins
    { import = 'plugins.themes' }, -- Theme plugins
    { import = 'plugins.ai' }, -- AI-related plugins
    { import = 'plugins.git' }, -- Git integration plugins
    { import = 'plugins.search' }, -- Search functionality plugins
    { import = 'plugins.terminal' }, -- Terminal integration plugins
    { import = 'plugins.session' }, -- Session management plugins
    { import = 'plugins.coding' }, -- Coding enhancement plugins
    { import = 'plugins.appearance' }, -- Appearance and UI plugins
  },
  -- Global configuration options for lazy.nvim.
  {
    -- Configuration for detecting changes in plugin configuration files.
    change_detection = {
      notify = false, -- If true, lazy.nvim shows a message when config files change. Set to false to disable.
    },
    -- Performance-related settings for lazy.nvim.
    performance = {
      rtp = {
        -- A list of built-in Neovim plugins to disable.
        -- Disabling unused plugins can improve startup time.
        disabled_plugins = {
          'gzip', -- Plugin for reading and writing gzip compressed files.
          'matchit', -- Extended % matching for HTML, LaTeX, and other languages.
          'matchparen', -- Highlights matching parentheses.
          'netrwPlugin', -- Built-in file explorer. Often replaced by other plugins.
          'tarPlugin', -- Plugin for working with tar files.
          'tohtml', -- Command to convert buffer to HTML.
          'tutor', -- Neovim tutor.
          'zipPlugin', -- Plugin for working with zip files.
        },
      },
    },
    -- UI configuration for the lazy.nvim interface.
    ui = {
      border = 'rounded', -- Use rounded borders for lazy.nvim's UI windows.
      wrap = true, -- Wrap long lines in the plugin list displayed by lazy.nvim.
      title = ' Plugins', -- Title displayed in the lazy.nvim UI window. (Icon requires a Nerd Font)
    },
  }
)
