return {
  {
    'Exafunction/windsurf.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('codeium').setup {
        -- Manually set the bin_path to the directory where the Codeium language server binary is located.
        -- This is required for WSL (Windows Subsystem for Linux) because automatic downloading of the binary
        -- often fails or results in misconfiguration. If bin_path is set to the binary file directly (instead of the directory),
        -- windsfurf.nvim will throw an error like:
        -- "E739: Cannot create directory ...: file already exists"
        -- So it is important to point only to the *directory* containing the binary.
        bin_path = vim.fn.expand '~/.cache/nvim/codeium/bin/1.8.9',
      }
      -- Keymaps for Codeium
      local keymap = vim.keymap.set
      keymap('n', '<leader>aw', '<cmd>Codeium Chat<CR>', { desc = 'Codeium Chat' })
    end,
  },
}
