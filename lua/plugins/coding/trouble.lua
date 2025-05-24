-- This file configures the folke/trouble.nvim plugin, which provides a
-- pretty list for diagnostics (errors, warnings), LSP references, symbols, etc.
-- It helps to visualize and navigate project-wide issues and code structures.

-- Return the plugin specification for lazy.nvim.
return {
  'folke/trouble.nvim', -- The plugin's repository name.
  cmd = 'Trouble', -- The main command to interact with Trouble.
                   -- Using `cmd` allows lazy-loading until this command is executed.
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Depends on nvim-web-devicons for icons in the list.
  opts = { -- Default options passed to Trouble's setup function.
    win = { -- Configuration for the Trouble window.
      type = 'split', -- How the Trouble window should be opened: 'split', 'vsplit', 'tab', 'float'.
      position = 'left', -- If using 'split' or 'vsplit', specifies the position ('left', 'right', 'top', 'bottom').
      size = 50, -- Size of the Trouble window (lines for horizontal split, columns for vertical).
    },
    -- Other common options for Trouble (not explicitly set here, so defaults are used):
    -- auto_open = false, -- Automatically open Trouble when diagnostics are found.
    -- auto_close = false, -- Automatically close Trouble when there are no more items.
    -- use_diagnostic_signs = true, -- Use diagnostic signs in the Trouble list.
    -- icons = true, -- Enable icons.
    -- fold_open = "", -- Nerd Font icon for open folds.
    -- fold_closed = "", -- Nerd Font icon for closed folds.
    -- mode = "workspace_diagnostics", -- Default mode when opening Trouble.
    --   Other modes: "document_diagnostics", "quickfix", "lsp_references", "lsp_definitions", etc.
  },
  keys = { -- Key mappings related to Trouble.
    {
      '<leader>dt', -- Key sequence (e.g., <Space>dt).
      '<cmd>Trouble diagnostics toggle<CR>', -- Command to execute: Toggle the Trouble window for diagnostics.
      desc = 'Toggle diagnostics Trouble', -- Description for which-key.
    },
    {
      '<leader>ds', -- Key sequence (e.g., <Space>ds).
      -- Command to execute: Toggle Trouble for document symbols.
      -- `win.position=left` overrides the default position for this specific invocation.
      '<cmd>Trouble symbols toggle win.position=left<CR>',
      desc = 'Document symbols Trouble', -- Description for which-key.
    },
    -- Other useful keymaps could be:
    -- { "[t", function() require("trouble").previous({skip_groups = true, jump = true}) end, desc = "Previous Trouble item" },
    -- { "]t", function() require("trouble").next({skip_groups = true, jump = true}) end, desc = "Next Trouble item" },
  },
}
