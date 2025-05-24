-- This file configures the Exafunction/windsurf.nvim plugin, which integrates
-- Codeium (a generative AI code completion tool) into Neovim.

-- Return the plugin specification for lazy.nvim.
return {
  {
    'Exafunction/windsurf.nvim', -- The plugin's repository name.
    dependencies = { -- List of plugins that windsurf.nvim depends on.
      'nvim-lua/plenary.nvim', -- Plenary provides utility functions.
      'hrsh7th/nvim-cmp', -- nvim-cmp is a completion plugin, Codeium can integrate with it.
    },
    config = function() -- Function to run after the plugin is loaded.
      require('codeium').setup { -- Initialize the Codeium integration.
        -- Manually set the bin_path to the directory where the Codeium language server binary is located.
        -- This is required for WSL (Windows Subsystem for Linux) because automatic downloading of the binary
        -- often fails or results in misconfiguration.
        -- If bin_path is set to the binary *file* directly (instead of the directory),
        -- windsurf.nvim (or its underlying Codeium logic) might throw an error like:
        -- "E739: Cannot create directory ...: file already exists"
        -- So it is important to point only to the *directory* containing the binary.
        -- The version number in the path (e.g., '1.8.9') might need to be updated
        -- if Codeium updates its language server versioning scheme or location.
        bin_path = vim.fn.expand '~/.cache/nvim/codeium/bin/1.8.9',
      }

      -- Keymaps for Codeium functionality.
      local keymap = vim.keymap.set -- Store vim.keymap.set for brevity.
      -- Map <leader>aw in Normal mode to open the Codeium Chat window.
      keymap('n', '<leader>aw', '<cmd>Codeium Chat<CR>', { desc = 'Codeium Chat' })
    end,
  },
}
