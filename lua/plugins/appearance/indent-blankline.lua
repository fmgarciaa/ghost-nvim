-- This file configures the indent-blankline.nvim plugin, which adds indentation guides
-- and scope lines to Neovim, enhancing code readability.

-- Return the plugin specification for lazy.nvim.
return {
  'lukas-reineke/indent-blankline.nvim', -- The plugin's repository name.
  main = 'ibl', -- Specifies the main module of the plugin for lazy.nvim.
  opts = { -- Default options passed to the plugin's setup function.
    indent = { -- Configuration for basic indentation lines.
      char = '┆', -- Character used for the indent line. (Pipe-like character)
                  -- Alternatives: '│', '▏', '▎', '▍', ' ', etc.
      smart_indent_cap = true, -- If true, caps indent lines at the start of text, improving appearance.
      highlight = { -- A list of highlight groups to cycle through for indent lines.
                    -- This creates "rainbow" indent lines, where each indent level has a different color.
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      },
    },
    scope = { -- Configuration for scope lines (visualizing code blocks).
      enabled = true, -- If true, enables scope lines.
      show_start = false, -- If true, shows a marker at the start of the scope.
      show_end = false, -- If true, shows a marker at the end of the scope.
      show_exact_scope = false, -- If true, highlights the exact scope; otherwise, it might be more indicative.
      highlight = { 'RainbowBlue' }, -- Highlight group for scope lines. Here, it's set to a single color.
    },
    whitespace = { -- Configuration for whitespace characters.
      remove_blankline_trail = true, -- If true, removes trailing whitespace from blank lines.
                                      -- Note: This plugin primarily focuses on indent visuals,
                                      -- so this option might be a minor utility or interact with indent display.
    },
    exclude = { -- Configuration for disabling the plugin in certain filetypes or buffer types.
      filetypes = { -- List of filetypes where indent-blankline will be disabled.
        'help',
        'startify', -- A startup screen plugin.
        'dashboard', -- Another startup screen plugin (e.g., alpha-nvim).
        'packer', -- Plugin manager interface.
        'neogitstatus', -- Git status window.
        'NvimTree', -- File explorer.
        'Trouble', -- Plugin for displaying diagnostics.
        'lazy', -- Lazy.nvim UI.
        'mason', -- Mason.nvim UI (package manager for LSPs, etc.).
        'terminal', -- Terminal buffers.
      },
      buftypes = { -- List of buffer types where indent-blankline will be disabled.
        'terminal',
        'nofile', -- Buffers not associated with a file.
        'quickfix', -- Quickfix list.
        'prompt', -- Prompt buffers.
      },
    },
  },
  config = function(_, opts) -- Function to run after the plugin is loaded.
    local hooks = require 'ibl.hooks' -- Load the hooks module from indent-blankline.

    -- Register a hook to set up the custom highlight groups for rainbow indent lines.
    -- This ensures the 'RainbowRed', 'RainbowYellow', etc., highlight groups are defined.
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' }) -- Define Red
      vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' }) -- Define Yellow
      vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' }) -- Define Blue
      vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' }) -- Define Orange
      vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' }) -- Define Green
      vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' }) -- Define Violet
      vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' }) -- Define Cyan
    end)

    -- Initialize indent-blankline with the specified options.
    require('ibl').setup(opts)

    -- Register a hook for scope highlighting.
    -- This uses a built-in function to handle scope highlighting based on extmarks,
    -- which is often necessary for correct interaction with Treesitter or LSP-based scopes.
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
