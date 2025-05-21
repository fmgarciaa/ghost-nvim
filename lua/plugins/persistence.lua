return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  config = function()
    require('persistence').setup {
      dir = vim.fn.stdpath 'state' .. '/sessions/',
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
    }

    -- Keymaps for persistence
    local keymaps = vim.keymap.set

    keymaps('n', '<leader>ps', function()
      require('persistence').load()
    end, { desc = 'Restore session for the current directory' })

    keymaps('n', '<leader>pS', function()
      require('persistence').select()
    end, { desc = 'Select a session to load' })

    keymaps('n', '<leader>pl', function()
      require('persistence').load { last = true }
    end, { desc = 'load the last session' })

    keymaps('n', '<leader>pd', function()
      require('persistence').stop()
    end, { desc = "Don't save the current session" })
  end,
}
