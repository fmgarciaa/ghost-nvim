return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('gruvbox').setup {
      contrast = 'hard',
      transparent_mode = false,
      overrides = {
        SignColumn = { bg = '#ff9900' },
      },
    }
    -- vim.cmd("colorscheme gruvbox")
  end,
}
