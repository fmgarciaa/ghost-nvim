-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    signs_staged = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    signs_staged_enable = true,
    signcolumn = true,
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local keymap = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
      end

      -- Navigation
      keymap('n', ']g', gs.next_hunk, 'Next Hunk')
      keymap('n', '[g', gs.prev_hunk, 'Prev Hunk')

      -- Actions
      keymap('n', '<leader>gs', gs.stage_hunk, 'Stage Hunk')
      keymap('n', '<leader>gr', gs.reset_hunk, 'Reset Hunk')
      keymap('n', '<leader>gS', gs.stage_buffer, 'Stage Buffer')
      keymap('n', '<leader>gR', gs.reset_buffer, 'Reset Buffer')
      keymap('n', '<leader>gu', gs.undo_stage_hunk, 'Undo Stage Hunk')

      -- Preview & diff
      keymap('n', '<leader>gp', gs.preview_hunk, 'Preview Hunk')
      keymap('n', '<leader>gd', gs.diffthis, 'Diff This')
      keymap('n', '<leader>gD', function()
        gs.diffthis '~'
      end, 'Diff With HEAD')
      keymap('n', '<leader>gb', function()
        gs.blame_line { full = true }
      end, 'Blame Line')
    end,
  },
}
