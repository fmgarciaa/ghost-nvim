-- This file defines the configuration for Lualine's built-in 'diff' component.
-- The 'diff' component displays information about changes in the current file
-- relative to the Git repository (lines added, modified, removed).

-- Configuration table for the 'diff' component.
local diff = {
  'diff', -- Specifies that this is the built-in 'diff' component.
  colored = true, -- If true, the symbols for added, modified, and removed lines will be colored.
                  -- The colors are typically provided by the Lualine theme or can be customized.
  symbols = { -- Defines the characters/icons used to represent different types of changes.
              -- These icons require a Nerd Font to be displayed correctly.
    added = ' ', -- Icon for added lines (e.g., a plus sign or Git's 'A').
    modified = ' ', -- Icon for modified lines (e.g., a dot or Git's 'M').
    removed = ' ', -- Icon for removed lines (e.g., a minus sign or Git's 'D').
  },
  -- Other options for the 'diff' component could be specified here, such as:
  -- diff_color = {
  --   added = { fg = 'green' },
  --   modified = { fg = 'orange' },
  --   removed = { fg = 'red' },
  -- },
  -- source = nil, -- Can be a function to provide custom diff counts.
}

-- Return the component configuration to be used by Lualine.
return diff
