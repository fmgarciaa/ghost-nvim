return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      model = 'gpt-4.1',
      debug = false,
      show_help = true,
      window = {
        layout = 'float',
        border = 'rounded',
      },
      context = { 'buffer', 'git:staged', 'filesnames' },
    },
    cmd = { 'CopilotChat', 'CopilotChatVisual' },
    keys = {
      { '<leader>ac', ':CopilotChat<CR>', mode = 'n', desc = 'Open Copilot Chat' },
      { '<leader>av', ':CopilotChatPrompts<CR>', mode = 'v', desc = 'Send selection to Copilot Chat' },
      { '<leader>ax', ':CopilotChat<CR>', desc = '[A]sk [C]opilot' },
    },
  },
}
