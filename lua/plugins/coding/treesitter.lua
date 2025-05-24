-- This file configures the nvim-treesitter/nvim-treesitter plugin, which provides
-- advanced syntax parsing for Neovim based on Tree-sitter. This enables more
-- accurate syntax highlighting, indentation, text objects, and more.

-- Return the plugin specification for lazy.nvim.
return {
  'nvim-treesitter/nvim-treesitter', -- The plugin's repository name.
  build = ':TSUpdate', -- Command to run after installing or updating the plugin.
                       -- ':TSUpdate' updates all installed Tree-sitter parsers.
  dependencies = { -- List of plugins that nvim-treesitter depends on or integrates with.
    'nvim-treesitter/nvim-treesitter-textobjects', -- Adds support for Tree-sitter based text objects (e.g., functions, classes).
  },
  opts = { -- Configuration options passed to nvim-treesitter's setup function.
    ensure_installed = { -- A list of Tree-sitter parsers to ensure are installed.
                         -- These parsers provide language-specific syntax understanding.
      'lua', 'python', 'javascript', 'typescript', 'vimdoc', 'vim', 'regex',
      'terraform', 'sql', 'dockerfile', 'toml', 'json', 'java', 'groovy', 'go',
      'gitignore', 'graphql', 'yaml', 'make', 'cmake', 'markdown', 'markdown_inline',
      'bash', 'tsx', 'css', 'html',
    },
    auto_install = true, -- If true, automatically installs missing parsers listed in `ensure_installed`
                         -- when Neovim starts or a relevant filetype is opened.

    highlight = { -- Configuration for syntax highlighting.
      enable = true, -- If true, enables Tree-sitter based syntax highlighting.
                     -- This generally provides more detailed and accurate highlighting than regex-based highlighting.
      additional_vim_regex_highlighting = { 'ruby' }, -- For some languages (like Ruby here),
                                                      -- Tree-sitter highlighting might be supplemented
                                                      -- or replaced by Vim's traditional regex highlighting if needed.
                                                      -- Setting it to `false` would disable Vim regex highlighting for all TS buffers.
    },
    indent = { -- Configuration for Tree-sitter based indentation.
      enable = true, -- If true, enables Tree-sitter based indentation.
      disable = { 'ruby' }, -- List of languages for which Tree-sitter indentation should be disabled.
                            -- Useful if a language's Tree-sitter indent is problematic or less preferred.
    },

    -- Configuration for nvim-treesitter-textobjects.
    textobjects = {
      select = { -- Defines keymaps for selecting text objects.
        enable = true, -- If true, enables these text object selection keymaps.
        lookahead = true, -- If true, improves the accuracy of selecting text objects by looking ahead in the syntax tree.
        keymaps = {
          -- These mappings work in Visual and Operator-pending modes.
          -- 'a' prefix usually means "around" (including delimiters/whitespace).
          -- 'i' prefix usually means "inside" (excluding delimiters/whitespace).
          ['af'] = '@function.outer', -- Select around a function.
          ['if'] = '@function.inner', -- Select inside a function.
          ['ac'] = '@class.outer', -- Select around a class.
          ['ic'] = '@class.inner', -- Select inside a class.
          ['aa'] = '@parameter.outer', -- Select around a parameter/argument.
          ['ia'] = '@parameter.inner', -- Select inside a parameter/argument.
          ['ab'] = '@block.outer', -- Select around a block of code.
          ['ib'] = '@block.inner', -- Select inside a block of code.
        },
      },
      move = { -- Defines keymaps for moving to the start/end of text objects.
        enable = true, -- If true, enables these text object movement keymaps.
        set_jumps = true, -- If true, adds movements to the Vim jump list (Ctrl+o, Ctrl+i). Essential for some plugins.
        goto_next_start = { -- Keymaps to move to the start of the next text object.
          [']f'] = '@function.outer', -- Move to the start of the next function.
          [']c'] = '@class.outer', -- Move to the start of the next class.
          [']a'] = '@parameter.outer', -- Move to the start of the next parameter.
        },
        goto_previous_start = { -- Keymaps to move to the start of the previous text object.
          ['[f'] = '@function.outer', -- Move to the start of the previous function.
          ['[c'] = '@class.outer', -- Move to the start of the previous class.
          ['[a'] = '@parameter.outer', -- Move to the start of the previous parameter.
        },
      },
      swap = { -- Defines keymaps for swapping text objects.
        enable = true, -- If true, enables these text object swapping keymaps.
        swap_next = { -- Keymap to swap the current text object with the next one.
          ['<leader>sa'] = '@parameter.inner', -- Swap current parameter with the next one.
        },
        swap_previous = { -- Keymap to swap the current text object with the previous one.
          ['<leader>sA'] = '@parameter.inner', -- Swap current parameter with the previous one.
        },
      },
      lsp_interop = { -- Configuration for interoperability with LSP features.
        enable = true, -- If true, enables LSP interop features.
        peek_definition_code = { -- Keymaps to peek (preview) the definition of a text object using LSP.
          ['<leader>sf'] = '@function.outer', -- Peek definition of the function under cursor.
          ['<leader>sc'] = '@class.outer', -- Peek definition of the class under cursor.
        },
      },
    },
  },
  config = function(_, opts) -- Function to run after the plugin is loaded and options are processed.
    -- Explicitly call setup for nvim-treesitter with the processed options.
    -- This ensures all modules, including textobjects, are correctly initialized.
    require('nvim-treesitter.configs').setup(opts)

    -- Optional: Enable repeatable movements for text objects using ';' and ','.
    -- This allows you to repeat the last text object movement (e.g., ']f') by pressing ';'.
    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next) -- Repeat next.
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous) -- Repeat previous.

    -- Custom user command for debugging text objects.
    -- Prints information about the currently configured text object movements.
    vim.api.nvim_create_user_command('DebugTextobjects', function()
      print(vim.inspect(require 'nvim-treesitter.textobjects.move'))
    end, {})
  end,
}
