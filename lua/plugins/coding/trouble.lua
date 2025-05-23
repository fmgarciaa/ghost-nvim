return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    win = {
      type = 'split',
      position = 'left',
      size = 50,
    },
  },
  keys = {
    { '<leader>dt', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Toggle diagnostics Trouble' },
    { '<leader>ds', '<cmd>Trouble symbols toggle win.position=left<CR>', desc = 'Document symbols Trouble' },
  },
}
