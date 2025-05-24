-- This file defines the configuration for Lualine's built-in 'mode' component.
-- The 'mode' component displays the current Neovim mode (e.g., Normal, Insert, Visual).

-- Configuration table for the 'mode' component.
local mode = {
  'mode', -- Specifies that this is the built-in 'mode' component.
  fmt = function(str) -- A function to format the mode string before display.
    -- `str` is the default mode string (e.g., "NORMAL", "INSERT").
    -- This function prepends a Nerd Font icon () and takes only the first letter of the mode string.
    -- Example: "NORMAL" becomes " N", "INSERT" becomes " I".
    return ' ' .. str:sub(1, 1)
  end,
  draw_empty = true, -- If true, the component will still allocate space even if the mode string is empty.
                     -- This helps maintain a consistent layout.
  color = { gui = 'bold' }, -- Sets the color/style for the mode text.
                           -- Here, it makes the mode text bold. The actual color will be determined by the Lualine theme.
                           -- Example: { fg = 'red', bg = '#000000', gui = 'bold,italic' }
  separator = { left = '', right = '' }, -- Defines separator characters to be placed to the left and right of the component.
                                         -- Here, no left separator and a Powerline-style arrow () as the right separator.
                                         -- These separators often use special characters or Nerd Font icons.
  -- Other potential options for the 'mode' component:
  -- padding = 0,
  -- icons_enabled = true, -- Though icons are often handled in `fmt` for more control.
  -- icon = '...', -- A static icon if not handled by `fmt`.
}

-- Return the component configuration to be used by Lualine.
return mode
