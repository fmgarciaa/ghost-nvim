-- This is the main initialization file for the Neovim configuration.
-- It is responsible for loading all other configuration modules.

-- Load general options for Neovim configuration.
-- This module likely sets global Neovim settings like 'clipboard', 'mouse', etc.
require 'core.options'

-- Load custom key mappings.
-- This module defines custom keyboard shortcuts for various actions.
require 'core.keymaps'

-- Load system-specific settings.
-- This module might handle configurations that depend on the operating system
-- or environment.
require 'core.system'

-- Initialize and configure Lazy.nvim plugin manager.
-- Lazy.nvim is used to manage Neovim plugins, including installation and loading.
require 'core.lazy-config'

-- Load custom commands.
-- This module defines custom Ex commands that can be used within Neovim.
require 'core.commands'
