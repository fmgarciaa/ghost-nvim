-- This file defines the configuration for Lualine's built-in 'lsp_progress' component.
-- This component displays information about ongoing Language Server Protocol (LSP) activities,
-- such as project scanning, indexing, or other background tasks reported by LSP servers.

-- Configuration table for the 'lsp_progress' component.
local lsp_spinner = {
  'lsp_progress', -- Specifies that this is the built-in 'lsp_progress' component.
  display_components = { 'lsp_client_name', 'spinner' }, -- Defines what parts of the progress info to show.
                                                       -- 'lsp_client_name': Shows the name of the LSP server reporting progress (e.g., "rust_analyzer").
                                                       -- 'spinner': Shows an animated spinner.
                                                       -- Other options could include 'title', 'message', 'percentage'.
  separators = { -- Defines separators used between the displayed components.
    spinner = { pre = '', post = '' }, -- No characters before or after the spinner itself.
                                       -- `pre` is prepended, `post` is appended.
    lsp_client_name = { pre = '[', post = ']' }, -- Enclose the LSP client name in square brackets.
  },
  timer = { -- Configuration for timing aspects of the component's display.
    spinner = 150, -- Interval in milliseconds for updating the spinner animation frame.
    progress_enddelay = 2500, -- Time in milliseconds to keep displaying the progress message after the LSP task has finished.
                              -- This allows users to see the completion message briefly.
    lsp_client_name_enddelay = 1000, -- Time in milliseconds to keep displaying the LSP client name after the task finishes.
  },
  spinner_symbols = { '', '', '', '', '', '' }, -- A list of characters (frames) for the spinner animation.
                                                     -- These are Nerd Font icons, creating a rotating effect.
  -- Other potential options for 'lsp_progress' include:
  -- color = { spinner = 'green', lsp_client_name = 'blue' }, -- Custom colors for components.
  -- padding = 0,
}

-- Return the component configuration to be used by Lualine.
return lsp_spinner
