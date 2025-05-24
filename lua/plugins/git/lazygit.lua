-- This file configures the kdheepak/lazygit.nvim plugin, which provides an
-- integration for Lazygit, a terminal UI for Git commands.

-- Return the plugin specification for lazy.nvim.
return {
  'kdheepak/lazygit.nvim', -- The plugin's repository name.
  lazy = true, -- Lazily load the plugin. It won't be loaded until one of its commands or events is triggered.
  cmd = { -- List of commands that will trigger the loading of this plugin.
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- Optional dependency for adding border decorations to Lazygit's floating window.
  dependencies = {
    'nvim-lua/plenary.nvim', -- Plenary provides utility functions that might be used by lazygit.nvim
                             -- or by extensions like the Telescope integration.
  },
  keys = { -- Key mappings related to Lazygit.
    {
      '<leader>gg', -- Key sequence (e.g., <Space>gg).
      '<cmd>LazyGit<CR>', -- Command to execute: Open the Lazygit terminal UI.
      desc = 'LazyGit', -- Description for which-key.
    },
  },
  config = function() -- Function to run after the plugin is loaded.
    -- Load the Telescope extension for Lazygit.
    -- This allows searching or interacting with Lazygit functionalities through Telescope's UI.
    -- For this to work, 'nvim-telescope/telescope.nvim' must also be installed and configured.
    -- The extension might provide pickers for commits, branches, etc., from Lazygit.
    if pcall(require, 'telescope') then -- Check if telescope is available before trying to load extension
      require('telescope').load_extension 'lazygit'
    end

    -- Other potential configurations for lazygit.nvim (not used here):
    -- vim.g.lazygit_floating_window_scaling_factor = 0.9 -- Adjust size of the floating window.
    -- vim.g.lazygit_floating_window_border_chars = {'╭','─','╮','│','╯','─','╰','│'} -- Custom border characters.
    -- vim.g.lazygit_use_plenary = true -- Or false, depending on whether to use plenary for job management.
    -- vim.g.lazygit_debug = true -- Enable debug logging.
  end,
}
