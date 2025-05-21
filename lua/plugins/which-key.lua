return {
  -- Hints keybinds
  'folke/which-key.nvim',
  config = function()
    local wk = require 'which-key'
    wk.add {
      { '<leader>p', group = 'Sesion Management' },
      { '<leader>f', group = 'Telescope [F]ind tools' },
      { '<leader>g', group = 'Git & Version Control' },
      { '<leader>t', group = 'Terminal Management' },
    }
  end,
}
