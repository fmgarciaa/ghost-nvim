-- This file configures the folke/which-key.nvim plugin, which displays a popup
-- with possible key bindings when a prefix key (like <leader>) is pressed and held.
-- This helps in discovering and remembering complex keymaps.

-- Return the plugin specification for lazy.nvim.
return {
  'folke/which-key.nvim', -- The plugin's repository name.
  config = function() -- Function to run after the plugin is loaded.
    local wk = require 'which-key' -- Load the main which-key module.

    -- Register groups of key mappings with descriptions for which-key to display.
    -- This helps organize related keymaps under a common prefix.
    wk.add {
      -- Each table entry defines a prefix and a group name or icon.
      { '<leader>p', group = 'Sesion Management' }, -- Mappings starting with <leader>p relate to Session Management.
      { '<leader>f', group = 'Telescope [F]ind tools' }, -- Mappings starting with <leader>f are for Telescope.
      { '<leader>g', group = 'Git & Version Control' }, -- Mappings starting with <leader>g are for Git.
      { '<leader>t', group = 'Terminal Management' }, -- Mappings starting with <leader>t are for Terminals.
      { '<leader>d', group = 'Diagnostic & LSP' }, -- Mappings starting with <leader>d are for Diagnostics and LSP.
      {
        '<leader>e', -- Mappings starting with <leader>e.
        group = 'Explorer Neotree', -- Group name for Neo-tree.
        icon = { icon = '', color = 'orange' }, -- Custom icon and color for this group. (Icon requires Nerd Font)
      },
      {
        '<leader>a', -- Mappings starting with <leader>a.
        group = 'AI', -- Group name for AI-related plugins.
        icon = { icon = '󰚩', color = 'blue' }, -- Custom icon and color. (Icon requires Nerd Font)
        mode = { 'n', 'v' }, -- This group is active in Normal ('n') and Visual ('v') modes.
      },
      -- Individual key mappings can also be registered here with their descriptions
      -- if they are not part of a larger plugin's keymap table that which-key automatically picks up.
      -- For example:
      -- { "<leader>w", "<cmd>w<CR>", desc = "Save File" }
    }
    -- Note: which-key also automatically integrates with key mappings set via `vim.keymap.set`
    -- if they have a `desc` field. The `wk.add` method is primarily for grouping and
    -- providing descriptions for prefixes or for mappings not defined with a `desc`.
  end,
}
