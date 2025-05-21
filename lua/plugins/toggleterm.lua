return {
  'akinsho/toggleterm.nvim',
  config = function()
    local toggleterm = require 'toggleterm'
    local Terminal = require('toggleterm.terminal').Terminal

    -- Configure toggleterm plugin
    toggleterm.setup {
      shade_terminals = true,
      insert_mappings = true,
      start_in_insert = true,
      persist_mode = true,
      auto_scroll = true,
      direction = 'horizontal',
      open_mapping = [[<C-_>]],
      autochdir = true,
      winbar = {
        enabled = true,
        name_formatter = function(term)
          -- Display a custom title in the winbar
          return ' terminal | id: ' .. term.id .. ' | cmd: ' .. (term.cmd or 'shell')
        end,
      },
      float_opts = {
        border = 'single',
        title_pos = 'left',
      },
    }

    -- Cache for terminal instances by filetype
    local file_runners = {}

    -- Map from filetype to interpreter command
    local cmd_map = {
      python = 'python3', -- use python3 for Python files
      lua = 'lua', -- use lua for Lua files
      sh = 'bash', -- use bash for shell scripts
      -- extend this table to support more filetypes
    }

    -- Function to run the current file in a floating terminal
    local function run_current_file()
      local ft = vim.bo.filetype
      local interp = cmd_map[ft]
      if not interp then
        -- Notify if this filetype isn't supported
        vim.notify('Unsupported filetype for execution: ' .. ft, vim.log.levels.WARN)
        return
      end

      local file = vim.fn.expand '%:p' -- get full path of the current file
      -- Get or create a terminal for this filetype
      local term = file_runners[ft]
      if not term then
        term = Terminal:new {
          cmd = interp .. ' ' .. file,
          hidden = true,
          direction = 'float',
          close_on_exit = false,
          auto_scroll = true,
          name = 'file_runner_' .. ft, -- give a unique name for reuse
        }
        file_runners[ft] = term
      else
        -- Update the command in case the file has changed
        term.cmd = interp .. ' ' .. file
      end

      -- Toggle the terminal visibility
      term:toggle()
    end

    -- Keymaps for toggleterm
    local keymap = vim.keymap.set
    keymap('n', '<leader>tr', run_current_file, { noremap = true, silent = true, desc = 'Running the current file' })
    keymap('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true, desc = 'Open floating terminal' })
  end,
}
