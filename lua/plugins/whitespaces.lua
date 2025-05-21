-- Highlight trailing whitespace and allow quick cleanup
return {
  'ntpeters/vim-better-whitespace',
  opts = {}, -- Plugin-specific options (empty as no extensive configuration is needed)
  config = function()
    -- Enable the plugin on startup
    vim.g.better_whitespace_enabled = 1

    -- Automatically strip trailing whitespace on save
    vim.g.strip_whitespace_on_save = 1

    -- Disable confirmation for whitespace stripping
    vim.g.strip_whitespace_confirm = 0

    -- Add keymap for manual whitespace cleanup
    -- local opts = { noremap = true, silent = true }
    -- vim.keymap.set("n", "<leader>w", ":StripWhitespace<CR>", opts) -- Shortcut to clean up trailing whitespace
  end,
}
