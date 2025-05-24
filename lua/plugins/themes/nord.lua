-- This file configures the Nord theme for Neovim, using the
-- shaunsingh/nord.nvim implementation. Nord is an arctic, north-bluish color palette.

-- Return the plugin specification for lazy.nvim.
return {
  'shaunsingh/nord.nvim', -- The plugin's repository name on GitHub.
  lazy = true, -- If true, this theme will only be loaded when explicitly commanded
               -- or if another plugin depends on it and triggers its loading.
               -- Setting `lazy = true` for a theme means it won't apply on startup
               -- unless `vim.cmd [[colorscheme nord]]` is called elsewhere or if it's
               -- the only theme not set to lazy and no other theme is explicitly loaded.
               -- For it to be a selectable theme without being the default, `lazy = true` is fine.
  config = function() -- Function to run after the plugin is loaded.
    -- Nord.nvim uses global Vim variables (g:nord_...) for its configuration.
    -- These settings must be applied *before* the colorscheme is set.

    -- `g.nord_contrast = true` enables a higher contrast mode for better readability.
    -- If false, uses the standard Nord contrast.
    vim.g.nord_contrast = true

    -- `g.nord_borders = false` disables borders for floating windows if the theme adds them.
    -- If true, floating windows (like LSP hover or Telescope) might have borders styled by Nord.
    vim.g.nord_borders = false

    -- `g.nord_disable_background = false` ensures that Nord sets its own background color.
    -- If true, it would make the background transparent, using the terminal's background.
    vim.g.nord_disable_background = false

    -- `g.nord_italic = false` disables italics for comments and other syntax groups
    -- where Nord might apply them by default. If true, enables them.
    vim.g.nord_italic = false

    -- `g.nord_uniform_diff_background = true` makes the background color for added/deleted lines
    -- in diff views more uniform, which can be less distracting for some users.
    vim.g.nord_uniform_diff_background = true

    -- `g.nord_bold = false` disables bold text for syntax groups where Nord might apply it.
    -- If true, enables bold text.
    vim.g.nord_bold = false

    -- The line to actually apply the colorscheme is commented out.
    -- `require("nord").set()` or `vim.cmd [[colorscheme nord]]` would apply the theme.
    -- If this theme is intended to be the default, this line (or its `vim.cmd` equivalent)
    -- should be uncommented, and `lazy` should probably be `false`.
    -- As it is, this file configures Nord but doesn't make it the active theme on startup.
    -- require("nord").set()
  end,
}
