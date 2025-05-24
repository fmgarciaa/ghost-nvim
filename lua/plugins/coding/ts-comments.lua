-- This file configures the folke/ts-comments.nvim plugin, which aims to provide
-- context-aware commenting for code, leveraging Treesitter information.
-- While the description mentions "Treesitter based commenting", the plugin itself
-- is quite minimal and might primarily serve as a placeholder or a base for
-- more advanced commenting logic that understands syntax nodes.
-- Standard comment plugins like 'numToStr/Comment.nvim' or 'JoosepAlviste/nvim-ts-context-commentstring'
-- (for context-aware comment strings) are often more feature-rich for general commenting needs.

-- Return the plugin specification for lazy.nvim.
return {
  'folke/ts-comments.nvim', -- The plugin's repository name.
  event = 'VeryLazy', -- Load this plugin very late, as commenting is usually not an immediate startup action.
                      -- 'BufReadPost' or specific ftplugin events could also be suitable.
  opts = {}, -- Pass an empty table for options.
             -- The plugin description indicates it often doesn't need extra configuration.
             -- If specific features were available, they would be configured here.
             -- For example: opts = { custom_comment_string_logic = true }
  -- config = function(_, opts)
  --   require('ts-comments').setup(opts) -- Standard setup call if needed.
  -- end,
  -- Given its minimal nature in many setups, it might be used alongside other commenting tools
  -- or for very specific Treesitter-aware commenting tasks if its features are expanded.
}
