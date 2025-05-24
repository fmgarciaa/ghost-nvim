-- This file defines a custom Lualine component for displaying GitHub Copilot status.
-- It leverages Lualine's component structure to show icons and colors based on Copilot's state.

-- The 'copilot' component configuration table.
local copilot = {
  'copilot', -- The first element is often the name of a built-in Lualine component or a function.
             -- In this case, it might be referencing a component provided by a Copilot plugin
             -- that integrates with Lualine, or it's a placeholder if the logic is self-contained
             -- or handled by Lualine's core based on this name.
  symbols = { -- Defines symbols (icons) and their corresponding states.
    status = { -- Status-specific icons and highlight groups.
      icons = {
        enabled = ' ', -- Icon displayed when Copilot is active and enabled. (Nerd Font icon)
        sleep = ' ', -- Icon when Copilot's auto-trigger is disabled or it's in a 'sleep' state. (Nerd Font icon)
        disabled = ' ', -- Icon displayed when Copilot is disabled. (Nerd Font icon)
        warning = ' ', -- Icon for Copilot warning states. (Nerd Font icon)
        unknown = ' ', -- Icon for unknown Copilot states. (Nerd Font icon)
      },
      hl = { -- Highlight groups (colors) for each status icon.
             -- These colors should ideally match the active Neovim colorscheme for consistency.
        enabled = '#0D4715', -- Dark green for enabled state.
        sleep = '#AEB7D0', -- Light grey/blue for sleep state.
        disabled = '#6272A4', -- Desaturated blue/purple for disabled state.
        warning = '#FFB86C', -- Yellow/orange for warning state.
        unknown = '#85193C', -- Dark red for unknown state.
      },
    },
    spinners = 'dots', -- Specifies the style of spinner to use during loading states.
                       -- 'dots' is a predefined spinner style in Lualine.
    spinner_color = '#6272A4', -- Color for the spinner animation.
  },
  show_colors = true, -- If true, applies the highlight colors defined in `symbols.status.hl`.
  show_loading = true, -- If true, displays the spinner and loading messages when Copilot is processing.
}

-- Return the component configuration to be used by Lualine.
return copilot
