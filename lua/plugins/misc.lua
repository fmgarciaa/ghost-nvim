-- This file is intended for miscellaneous plugins that have minimal configuration
-- (typically less than 10 lines or using default settings).
-- It helps keep the plugin management organized by grouping smaller plugins together.

-- Return a list of plugin specifications for lazy.nvim.
return {
  {
    -- Plugin for seamless navigation between Neovim splits and Tmux panes.
    -- Allows using the same keybindings (Ctrl-h/j/k/l by default) to navigate
    -- across Vim splits and Tmux panes.
    'christoomey/vim-tmux-navigator',
    -- No specific config function or opts needed; it usually works out-of-the-box
    -- by setting up its own keymaps.
  },
  {
    -- Automatically detects indentation settings (tabstop, shiftwidth, expandtab)
    -- for the current file based on its content.
    -- Useful when working on projects with varying coding styles.
    'tpope/vim-sleuth',
    -- No specific config needed; it works on buffer load.
  },
  {
    -- A Git wrapper for Neovim, providing a powerful set of Git commands
    -- accessible directly within the editor (e.g., :Git blame, :Git commit, :Git status).
    'tpope/vim-fugitive',
    -- No specific config needed for basic functionality.
    -- It's often used with other plugins like vim-rhubarb or gitsigns.
  },
  {
    -- Enhances vim-fugitive by providing GitHub-specific features.
    -- For example, :GBrowse to open the current file or commit on GitHub.
    'tpope/vim-rhubarb',
    -- Depends on vim-fugitive. No specific config needed.
  },
  {
    -- Improves escaping from Insert mode to Normal mode.
    -- Allows using a quick sequence like 'jk' or 'jj' to exit Insert mode
    -- instead of reaching for the Escape key, with configurable timeout.
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup({
        -- Default mapping is "jk"
        -- timeout = vim.o.timeoutlen, -- Uses Vim's timeout length by default.
        -- clear_empty_lines = false, -- If true, clears the typed mapping if it's on an empty line.
        -- keycodes = { 'j', 'k' }, -- The key sequence to use for escaping.
      })
    end,
  },
  {
    -- Automatically inserts closing pairs for parentheses, brackets, quotes, etc.
    -- (e.g., typing '(' will insert '()').
    'windwp/nvim-autopairs',
    event = 'InsertEnter', -- Load the plugin when entering Insert mode.
    config = true, -- A shorthand for `config = function() require('nvim-autopairs').setup(opts) end`
                   -- when `opts` are provided or default setup is sufficient.
    opts = { -- Options for nvim-autopairs. An empty table means default options are used.
      -- check_ts = true, -- Enable Treesitter integration for better context awareness (recommended).
      -- map_cr = true, -- Map <CR> to insert a new line intelligently within pairs.
    },
  },
  {
    -- Highlights TODO, FIXME, NOTE, HACK, etc., comments in code, making them more visible.
    'folke/todo-comments.nvim',
    event = 'VimEnter', -- Load when Neovim has fully started.
                       -- Can also be 'BufReadPost' or 'FileType' for more targeted loading.
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Depends on Plenary for utility functions.
    opts = {
      signs = false, -- If true, adds signs to the signcolumn for TODOs. Disabled here.
      -- keywords = { ... } -- Can customize keywords and their highlighting.
      -- highlight = { ... } -- Can customize highlight groups.
    },
  },
  {
    -- Provides advanced multi-cursor editing capabilities, similar to Sublime Text
    -- or VS Code's multi-cursor features.
    'mg979/vim-visual-multi',
    -- Often configured via global variables or has its own keymaps.
    -- No specific Lua config function needed here for default behavior.
  },
  {
    -- A high-performance plugin for highlighting color codes (e.g., #RRGGBB, rgb())
    -- in text files with their actual colors.
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
        -- filetypes = { '*' }, -- Attach to all filetypes by default.
        -- user_default_options = {
        --   RGB = true, -- Highlight RGB functional notation (e.g., rgb(0,0,0))
        --   RRGGBB = true, -- Highlight RRGGBB hex codes
        --   names = true, -- Highlight named colors like "red", "blue"
        --   tailwind = false, -- Enable Tailwind CSS color highlighting
        --   mode = 'background', -- Highlight mode: 'foreground' or 'background'
        -- },
      })
    end,
  },
  {
    -- Lualine component to display GitHub Copilot status.
    -- Assumes lualine and copilot.lua (or similar) are also configured.
    'AndreM222/copilot-lualine',
    -- No specific config, it registers itself with Lualine if Lualine is present.
  },
  {
    -- Lualine component to display LSP progress.
    -- Assumes lualine is configured.
    'arkav/lualine-lsp-progress',
    -- No specific config, integrates with Lualine.
  },
  {
    -- Provides a breadcrumb navigation display (e.g., file > class > function)
    -- based on LSP document symbols. Often shown in the statusline or winbar.
    'SmiteshP/nvim-navic',
    lazy = true, -- Load lazily, typically attached by LSP `on_attach` function.
    requires = 'neovim/nvim-lspconfig', -- Explicitly state dependency, though not strictly needed by lazy.nvim.
                                        -- It's more of a logical dependency.
    -- Configuration for nvim-navic is usually done in the LSP `on_attach` function.
  },
  {
    -- A collection of minimal, standalone Lua modules for Neovim (mini.nvim).
    -- This entry might be for installing the entire suite or specific modules from it.
    -- Using `version = '*'` typically means track the latest stable release or main branch.
    'echasnovski/mini.nvim',
    version = '*', -- Consider pinning to a specific version/tag for stability.
    -- Individual mini modules are often configured separately if used, e.g.:
    -- require('mini.ai').setup()
    -- require('mini.pairs').setup()
    -- No global config function here implies either default behavior for all installed
    -- mini modules or that specific modules will be configured elsewhere if needed.
  },
}
