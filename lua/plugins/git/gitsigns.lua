-- This file configures the lewis6991/gitsigns.nvim plugin, which shows Git
-- change markers (signs) in the signcolumn (gutter) and provides utilities
-- for hunk navigation, staging, and blaming.

-- Return the plugin specification for lazy.nvim.
return {
  'lewis6991/gitsigns.nvim', -- The plugin's repository name.
  event = { 'BufReadPre', 'BufNewFile' }, -- Load the plugin early when a buffer is read or a new file is created.
                                         -- This ensures signs are available quickly.
  dependencies = { -- List of plugins that gitsigns.nvim depends on.
    'nvim-lua/plenary.nvim', -- Plenary provides utility functions used by gitsigns.
  },
  opts = { -- Configuration options passed to gitsigns' setup function.
    signs = { -- Define the appearance of signs for unstaged changes.
      add = { text = '+' }, -- Text displayed for added lines.
      change = { text = '~' }, -- Text for changed lines.
      delete = { text = '_' }, -- Text for deleted lines (marker shown above the deletion).
      topdelete = { text = '‾' }, -- Text for deleted lines when the deletion is at the top of the hunk.
      changedelete = { text = '~' }, -- Text for lines that were changed and then deleted.
                                   -- Note: Some themes might provide icons via `hl` (highlight group) instead of `text`.
    },
    signs_staged = { -- Define the appearance of signs for staged changes.
                     -- These have the same structure as `signs` but apply to changes added to the Git index.
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    signs_staged_enable = true, -- If true, enables distinct signs for staged changes.
                               -- If false, staged changes might use the same signs as unstaged or no signs.
    signcolumn = true, -- If true, always show the signcolumn. If false, it might only appear when there are signs.
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>', -- Format for the blame message shown on the current line.
                                                                          -- Placeholders: <author>, <author_time:%Y-%m-%d>, <summary>, etc.
                                                                          -- %R gives time in HH:MM format.
    on_attach = function(bufnr) -- Function to run when gitsigns attaches to a buffer.
                               -- `bufnr` is the buffer number.
      local gs = package.loaded.gitsigns -- Get the gitsigns module, ensuring it's loaded.
      -- Helper function to set buffer-local keymaps.
      local keymap = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
      end

      -- Navigation keymaps for moving between hunks (blocks of changes).
      keymap('n', ']g', gs.next_hunk, 'Next Hunk') -- Go to the next hunk.
      keymap('n', '[g', gs.prev_hunk, 'Prev Hunk') -- Go to the previous hunk.

      -- Actions for staging and resetting changes.
      keymap('n', '<leader>gs', gs.stage_hunk, 'Stage Hunk') -- Stage the current hunk.
      keymap('n', '<leader>gr', gs.reset_hunk, 'Reset Hunk') -- Reset (unstage and discard changes of) the current hunk.
      keymap('n', '<leader>gS', gs.stage_buffer, 'Stage Buffer') -- Stage all changes in the current buffer.
      keymap('n', '<leader>gR', gs.reset_buffer, 'Reset Buffer') -- Reset all changes in the current buffer.
      keymap('n', '<leader>gu', gs.undo_stage_hunk, 'Undo Stage Hunk') -- Unstage the previously staged hunk.

      -- Preview and diffing functionalities.
      keymap('n', '<leader>gp', gs.preview_hunk, 'Preview Hunk') -- Show a preview of the current hunk in a floating window.
      keymap('n', '<leader>gd', gs.diffthis, 'Diff This') -- Diff the current buffer against the version in the Git index (staged version).
      keymap('n', '<leader>gD', function()
        gs.diffthis '~' -- Diff the current buffer against the version in HEAD (last commit).
      end, 'Diff With HEAD')
      keymap('n', '<leader>gb', function()
        gs.blame_line { full = true } -- Show blame information for the current line in a floating window.
                                     -- `full = true` shows the full commit message.
      end, 'Blame Line')
      -- Other useful gitsigns functions not mapped here include:
      -- gs.set_current_hunk_base(), gs.select_hunk(), gs.stage_hunk_partially()
    end,
  },
}
