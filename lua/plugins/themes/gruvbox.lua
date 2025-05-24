-- This file configures the Gruvbox theme for Neovim, specifically using the
-- ellisonleao/gruvbox.nvim implementation. Gruvbox is a popular retro groove color scheme.

-- Return the plugin specification for lazy.nvim.
return {
  'ellisonleao/gruvbox.nvim', -- The plugin's repository name on GitHub.
  lazy = false, -- Load this plugin eagerly on startup.
                -- Themes are typically loaded non-lazily.
  priority = 1000, -- High priority to ensure the theme is applied early.
  config = function() -- Function to run after the plugin is loaded.
    require('gruvbox').setup { -- Call the theme's setup function.
      -- `contrast` adjusts the intensity of background and foreground colors.
      -- 'hard', 'medium', 'soft' are common options. 'hard' provides the highest contrast.
      contrast = 'hard',

      -- `transparent_mode` (often named `transparent_background` in other themes)
      -- If true, uses the terminal's background instead of the theme's.
      transparent_mode = false, -- Set to false for the opaque Gruvbox background.

      -- `overrides` allows customizing specific highlight groups.
      -- This is a powerful feature to tailor the theme to personal preferences
      -- or to improve visibility for certain UI elements.
      overrides = {
        -- Example: Change the background color of the SignColumn.
        -- The SignColumn is where diagnostic signs, Git signs, etc., are displayed.
        -- '#ff9900' is a bright orange color.
        SignColumn = { bg = '#ff9900' },
        -- Many other highlight groups can be overridden here.
        -- e.g., "CursorLine" = { bg = "#3c3836" }, "NormalFloat" = { bg = "grey" }
      },
      -- Other gruvbox.nvim options (not explicitly set here, so defaults apply):
      -- palette_overrides = {}, -- Override specific colors in the Gruvbox palette.
      -- terminal_colors = true, -- If true, sets Neovim terminal colors to match Gruvbox.
      -- bold = true, -- Enable bold text where appropriate.
      -- italics = { strings = true, comments = true, keywords = false, ... }, -- Fine-tune italics.
      -- undercurl = true, -- Enable undercurl for diagnostics.
      -- ... and more, see plugin documentation.
    }

    -- The command to apply the colorscheme is commented out here.
    -- `vim.cmd("colorscheme gruvbox")`
    -- If this line is uncommented, Gruvbox would become the active theme upon startup.
    -- If another theme (like Catppuccin in this setup) is intended to be the default,
    -- this line should remain commented or be conditional.
    -- To set Gruvbox as the default, uncomment this line and ensure other themes'
    -- `vim.cmd [[colorscheme ...]]` lines are commented out or removed.
  end,
}
