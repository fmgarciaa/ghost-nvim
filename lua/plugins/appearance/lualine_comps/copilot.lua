-- Lualine configuration with the 'copilot' component
local copilot = {
  'copilot',
  symbols = {
    status = {
      icons = {
        enabled = ' ', -- Icon when Copilot is enabled
        sleep = ' ', -- Icon when auto-trigger is disabled
        disabled = ' ', -- Icon when Copilot is disabled
        warning = ' ', -- Icon for warning states
        unknown = ' ', -- Icon for unknown states
      },
      hl = {
        enabled = '#0D4715',
        sleep = '#AEB7D0',
        disabled = '#6272A4',
        warning = '#FFB86C',
        unknown = '#85193C',
      },
    },
    spinners = 'dots', -- Uses the predefined "dots" spinner
    spinner_color = '#6272A4', -- Color of the spinner
  },
  show_colors = true, -- Show colors in the status
  show_loading = true, -- Show loading status
}

return copilot
