-- This file configures the Catppuccin theme for Neovim.
-- Catppuccin is a popular, soothing pastel theme with multiple "flavours".

-- Return the plugin specification for lazy.nvim.
return {
  'catppuccin/nvim', -- The plugin's repository name on GitHub.
  name = 'catppuccin', -- A custom name for the plugin (optional, often defaults to the repo name).
                       -- Useful if you want to refer to it by this name, e.g., for dependencies.
  lazy = false, -- If false, load this plugin eagerly on startup.
                -- Themes are often loaded non-lazily to apply them as soon as Neovim starts.
                -- If true, it would only load when explicitly required or an event triggers it.
  priority = 1000, -- A higher priority means this plugin's setup/config runs earlier
                   -- relative to other plugins with lower priorities.
                   -- Important for themes to ensure they are applied before UI elements are drawn.
  config = function() -- Function to run after the plugin is loaded.
    require('catppuccin').setup { -- Call the theme's setup function.
      flavour = 'frappe', -- Catppuccin has multiple flavours: 'latte', 'frappe', 'macchiato', 'mocha'.
                          -- 'frappe' is one of the darker variants.
      transparent_background = false, -- If true, uses the terminal's background color instead of the theme's.
                                     -- Set to false for an opaque background defined by Catppuccin.
      term_colors = true, -- If true, sets the Neovim terminal's colors to match the Catppuccin theme.
      -- Other Catppuccin options (not explicitly set here, so defaults apply):
      -- show_end_of_buffer = false, -- If true, shows a character at the end of the buffer.
      -- no_italic = false, -- If true, disables italics.
      -- no_bold = false, -- If true, disables bold text.
      -- no_underline = false, -- If true, disables underlines.
      -- styles = { ... }, -- Fine-tune styles for comments, functions, keywords, etc.
      -- color_overrides = { ... }, -- Override specific colors in the palette.
      -- custom_highlights = function(colors) return { ... } end, -- Define custom highlight groups.
      -- integrations = { ... }, -- Enable/configure integrations with other plugins (e.g., Telescope, Lualine).
    }
    -- Apply the colorscheme after setting it up.
    -- This command makes Catppuccin the active theme.
    vim.cmd [[colorscheme catppuccin]]
  end,
}
