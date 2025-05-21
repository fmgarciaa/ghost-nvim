return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = false, -- Enables inline suggestions
          auto_trigger = false, -- If `true`, Copilot will suggest automatically
          debounce = 75, -- Time in milliseconds to wait before suggesting
          keymap = {
            accept = '<Tab>', -- Key to accept the suggestion
            next = '<C-j>', -- Key to navigate to the next suggestion
            prev = '<C-k>', -- Key to navigate to the previous suggestion
            dismiss = '<C-c>', -- Key to dismiss the suggestion
          },
        },
        panel = {
          enabled = false, -- Enables the multiple suggestions panel
          auto_refresh = true,
          keymap = {
            jump_next = '<C-n>', -- Key to jump to the next suggestion
            jump_prev = '<C-p>', -- Key to jump to the previous suggestion
            refresh = '<C-r>', -- Key to refresh the panel
            accept = '<CR>', -- Key to accept the current suggestion
          },
          layout = {
            position = 'left', -- Panel position ("bottom", "top", "left", "right")
            ratio = 0.2, -- Relative size of the panel
          },
        },
        filetypes = {
          yaml = false, -- Disables Copilot for YAML (example)
          markdown = true, -- Enables Copilot for Markdown
          python = true, -- Enables Copilot for Python
          lua = true, -- Enables Copilot for Lua
          ['*'] = true, -- Enables Copilot for all other files
        },
      }
    end,
  },
}
