-- This file configures the windwp/nvim-ts-autotag plugin, which automatically
-- renames or closes HTML/XML tags based on Treesitter parsing.
-- For example, if you change an opening `<div>` tag, the corresponding `</div>` will update.
-- If you type `>` in an opening tag, it can automatically insert the closing tag.

-- Return the plugin specification for lazy.nvim.
return {
  { -- Note: This plugin is wrapped in an extra table, which is fine for lazy.nvim.
    'windwp/nvim-ts-autotag', -- The plugin's repository name.
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Depends on nvim-treesitter for syntax parsing.
                                                        -- It needs Treesitter to understand the structure of tags.
    config = function() -- Function to run after the plugin is loaded.
      require('nvim-ts-autotag').setup({
        -- Default options are usually sufficient.
        -- Some common options (not explicitly set here, so defaults apply):
        -- enable_rename = true, -- Automatically rename paired tags.
        -- enable_close = true, -- Automatically close tags when '>' is typed.
        -- enable_close_on_slash = true, -- Automatically close self-closing tags when '/' is typed.
        -- filetypes = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte", ... }, -- Enabled filetypes.
      })
    end,
  },
}
