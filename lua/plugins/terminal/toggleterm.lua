-- This file configures the akinsho/toggleterm.nvim plugin, which provides
-- easily toggleable terminal windows within Neovim for running commands,
-- scripts, or interactive shells.

-- Return the plugin specification for lazy.nvim.
return {
  'akinsho/toggleterm.nvim', -- The plugin's repository name.
  config = function() -- Function to run after the plugin is loaded.
    local toggleterm = require 'toggleterm' -- Load the main toggleterm module.
    local Terminal = require('toggleterm.terminal').Terminal -- Import the Terminal class for creating custom terminals.

    -- Global setup for toggleterm. These settings apply to most terminals
    -- created by the plugin unless overridden by a specific terminal's configuration.
    toggleterm.setup {
      shade_terminals = true, -- If true, non-active terminal windows will be shaded (dimmed).
      insert_mappings = true, -- If true, default key mappings for opening terminals will work in Insert mode.
      start_in_insert = true, -- If true, terminals will start in Insert mode by default.
      persist_mode = true, -- If true, the terminal mode (Insert/Normal) is persisted across toggles.
      auto_scroll = true, -- If true, automatically scroll to the bottom of the terminal on new output.
      direction = 'horizontal', -- Default direction for new terminals: 'horizontal' (bottom split),
                                -- 'vertical' (right split), or 'float' (floating window).
      open_mapping = [[<C-_>]], -- Default key mapping to toggle the main terminal.
                                -- <C-_> is Ctrl+Underscore. Note: some terminals might not send this keycode correctly.
                                -- Consider alternatives like <C-\> or <leader>t.
      autochdir = true, -- If true, terminals will automatically change directory to the current buffer's directory.
                        -- This can be useful for project-specific tasks.
      winbar = { -- Configuration for the winbar (a small bar at the top of the terminal window).
        enabled = true, -- If true, show the winbar.
        name_formatter = function(term) -- Function to format the text displayed in the winbar.
          -- `term` is the terminal object, providing access to `term.id`, `term.cmd`, etc.
          -- This displays an icon, terminal ID, and the command being run. (Icon requires Nerd Font)
          return ' terminal | id: ' .. term.id .. ' | cmd: ' .. (term.cmd or 'shell')
        end,
      },
      float_opts = { -- Default options for floating terminals.
        border = 'single', -- Style of the border for floating terminal windows ('single', 'double', 'rounded', etc.).
        title_pos = 'left', -- Position of the title in the floating window's border.
      },
      -- Other options:
      -- size = 20, -- Default size (lines for horizontal, columns for vertical).
      -- shell = vim.o.shell, -- Default shell to use.
      -- hidden = false, -- If true, newly created terminals are hidden by default.
    }

    -- Cache for terminal instances used for running files, keyed by filetype.
    -- This allows reusing the same terminal for a specific filetype.
    local file_runners = {}

    -- Map from filetype to the interpreter command used to run files of that type.
    local cmd_map = {
      python = 'python3', -- Use 'python3' for Python files.
      lua = 'lua', -- Use 'lua' for Lua files.
      sh = 'bash', -- Use 'bash' for shell scripts.
      -- This table can be extended to support running files of other types.
      -- Example: javascript = 'node', go = 'go run'
    }

    -- Function to run the current file in a dedicated floating terminal.
    -- The terminal is reused if one already exists for the filetype.
    local function run_current_file()
      local ft = vim.bo.filetype -- Get the filetype of the current buffer.
      local interp = cmd_map[ft] -- Get the interpreter command for this filetype.

      -- If no interpreter is defined for the filetype, show a warning and exit.
      if not interp then
        vim.notify('Unsupported filetype for execution: ' .. ft, vim.log.levels.WARN)
        return
      end

      local file = vim.fn.expand '%:p' -- Get the full path of the current file.
      local term = file_runners[ft] -- Try to get an existing terminal for this filetype from the cache.

      if not term then
        -- If no terminal exists for this filetype, create a new one.
        term = Terminal:new {
          cmd = interp .. ' ' .. file, -- Command to execute (interpreter + file path).
          hidden = true, -- Create the terminal hidden; it will be toggled visible later.
          direction = 'float', -- Make this a floating terminal.
          close_on_exit = false, -- Keep the terminal window open after the command exits to see output.
                                -- Set to true if you want it to close immediately.
          auto_scroll = true, -- Enable auto-scroll.
          name = 'file_runner_' .. ft, -- Give a unique name for potential reuse or identification.
        }
        file_runners[ft] = term -- Cache the new terminal instance.
      else
        -- If a terminal for this filetype already exists, update its command
        -- in case the file path or interpreter needs to change (though `file` changes more often).
        -- Note: Re-setting `term.cmd` might not always re-run the command if the terminal is already open
        -- and the process is still running. Behavior depends on toggleterm's internals.
        -- A more robust way might be to close and recreate or send commands to the existing terminal.
        term.cmd = interp .. ' ' .. file
      end

      -- Toggle the terminal's visibility (open it if hidden, or bring to front if open but obscured).
      term:toggle()
    end

    -- Keymaps for toggleterm.
    local keymap = vim.keymap.set -- Shorthand for vim.keymap.set.

    -- Map <leader>tr in Normal mode to run the current file using the `run_current_file` function.
    keymap('n', '<leader>tr', run_current_file, { noremap = true, silent = true, desc = 'Running the current file' })

    -- Map <leader>tf in Normal mode to open a generic floating terminal.
    -- ':ToggleTerm direction=float' overrides the default direction for this specific mapping.
    keymap('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true, desc = 'Open floating terminal' })

    -- Other useful keymaps could include toggling specific named terminals or terminals with specific commands.
    -- Example:
    -- function _lazygit_toggle()
    --   local term = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float", name = "lazygit_term" })
    --   term:toggle()
    -- end
    -- keymap("n", "<leader>lg", _lazygit_toggle, { desc = "Toggle Lazygit terminal" })
  end,
}
