-- This file configures the zbirenbaum/copilot.lua plugin, which provides GitHub Copilot
-- suggestions and panel functionality within Neovim.

-- Return the plugin specification for lazy.nvim.
return {
  {
    'zbirenbaum/copilot.lua', -- The plugin's repository name.
    cmd = 'Copilot', -- Command to manually trigger Copilot actions (e.g., :Copilot enable).
                     -- Also makes the plugin load when this command is first used.
    event = 'InsertEnter', -- Load the plugin when entering Insert mode.
                           -- This helps to have suggestions ready when starting to type.
    config = function() -- Function to run after the plugin is loaded.
      require('copilot').setup { -- Initialize the plugin with its configuration options.
        suggestion = { -- Configuration for inline code suggestions.
          enabled = false, -- If true, inline suggestions are shown as you type.
                           -- Set to false here, meaning suggestions are likely triggered manually or by other means.
          auto_trigger = false, -- If true, Copilot will attempt to provide suggestions automatically.
                                -- If false, suggestions might need to be explicitly requested.
          debounce = 75, -- Time in milliseconds to wait after typing before requesting suggestions.
                         -- Helps to avoid excessive requests while typing quickly.
          keymap = { -- Key mappings for interacting with suggestions.
            accept = '<Tab>', -- Press Tab to accept the current suggestion.
            next = '<C-j>', -- Press Ctrl+j to cycle to the next suggestion.
            prev = '<C-k>', -- Press Ctrl+k to cycle to the previous suggestion.
            dismiss = '<C-c>', -- Press Ctrl+c to dismiss the current suggestion.
          },
        },
        panel = { -- Configuration for the Copilot panel, which can show multiple suggestions.
          enabled = false, -- If true, the Copilot panel is available.
                           -- Set to false here, meaning the panel is not used or triggered by default.
          auto_refresh = true, -- If true, the panel will automatically refresh suggestions.
          keymap = { -- Key mappings for interacting with the panel.
            jump_next = '<C-n>', -- Press Ctrl+n to jump to the next suggestion in the panel.
            jump_prev = '<C-p>', -- Press Ctrl+p to jump to the previous suggestion in the panel.
            refresh = '<C-r>', -- Press Ctrl+r to manually refresh the suggestions in the panel.
            accept = '<CR>', -- Press Enter to accept the currently selected suggestion in the panel.
          },
          layout = { -- Configuration for the panel's appearance and position.
            position = 'left', -- Position of the panel: "bottom", "top", "left", or "right".
            ratio = 0.2, -- Relative size of the panel (e.g., 0.2 means 20% of the editor width/height).
          },
        },
        filetypes = { -- Configuration for enabling/disabling Copilot for specific filetypes.
          yaml = false, -- Copilot is disabled for YAML files.
          markdown = true, -- Copilot is enabled for Markdown files.
          python = true, -- Copilot is enabled for Python files.
          lua = true, -- Copilot is enabled for Lua files.
          ['*'] = true, -- Copilot is enabled by default for all other filetypes not explicitly listed.
        },
      }
    end,
  },
}
