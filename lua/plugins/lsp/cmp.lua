-- This file configures hrsh7th/nvim-cmp, a completion plugin for Neovim.
-- nvim-cmp provides a framework for completion sources (LSP, snippets, buffer, path, etc.)
-- and a UI for selecting completions.

-- Return the plugin specification for lazy.nvim.
return {
  {
    'hrsh7th/nvim-cmp', -- The plugin's repository name.
    event = 'InsertEnter', -- Load the plugin when entering Insert mode, as completions are typically used then.
    dependencies = { -- List of plugins that nvim-cmp depends on or integrates with.
      'zbirenbaum/copilot-cmp', -- Integration for GitHub Copilot suggestions in nvim-cmp.
      'hrsh7th/cmp-nvim-lsp', -- Source for LSP completions.
      'hrsh7th/cmp-buffer', -- Source for completions from words in the current buffer.
      'hrsh7th/cmp-path', -- Source for file system path completions.
      'L3MON4D3/LuaSnip', -- Snippet engine. nvim-cmp can integrate with LuaSnip to expand snippets.
      'saadparwaiz1/cmp_luasnip', -- Adapter for LuaSnip to be used as a cmp source.
      'onsails/lspkind-nvim', -- Provides icons for completion items based on their kind (function, variable, etc.).
    },
    config = function() -- Function to run after the plugin is loaded.
      -- 1. Setup for copilot-cmp (GitHub Copilot integration).
      require('copilot_cmp').setup {
        method = 'getCompletions', -- Method used to fetch Copilot completions.
        event = { 'InsertEnter', 'LspAttach' }, -- Events that can trigger Copilot suggestions.
        fix_pairs = true, -- If true, attempts to fix paired characters (like quotes, brackets) when accepting Copilot suggestions.
      }

      local cmp = require 'cmp' -- Load the main nvim-cmp module.
      local luasnip = require 'luasnip' -- Load LuaSnip for snippet expansion.
      local lspkind = require 'lspkind' -- Load lspkind for completion item icons.

      -- 2. Helper function to check if there are words before the cursor.
      -- Used in the Tab key mapping to decide whether to select a completion or fallback to Tab.
      local has_words_before = function()
        local line, col = table.unpack(vim.api.nvim_win_get_cursor(0)) -- Get current cursor position.
        -- Check if the column is not 0 and the text before the cursor on the current line is not only whitespace.
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
      end

      -- 3. Define custom highlight groups for Copilot and Codeium completion items.
      -- This allows styling these sources differently in the completion menu.
      vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' }) -- Green for Copilot.
      vim.api.nvim_set_hl(0, 'CmpItemKindCodeium', { fg = '#00BFFF' }) -- Blue for Codeium.

      -- Main setup for nvim-cmp.
      cmp.setup {
        snippet = { -- Configuration for snippet expansion.
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Use LuaSnip to expand snippets.
          end,
        },
        mapping = cmp.mapping.preset.insert { -- Key mappings for the completion menu in Insert mode.
          ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation window up.
          ['<C-f>'] = cmp.mapping.scroll_docs(4), -- Scroll documentation window down.
          ['<C-Space>'] = cmp.mapping.complete(), -- Manually trigger completion.
          ['<CR>'] = cmp.mapping.confirm { select = true }, -- Confirm selection. `select = true` means if no item is selected, it still confirms (e.g., inserts a newline).
          -- Tab navigation for selecting next/previous items.
          -- Uses vim.schedule_wrap to ensure cmp functions are called safely.
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then -- If completion menu is visible and there's text before cursor.
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select } -- Select next item.
            else
              fallback() -- Otherwise, execute the fallback (default Tab behavior).
            end
          end, { 'i', 's' }), -- Apply in Insert ('i') and Select ('s') modes (for snippets).
          ['<S-Tab>'] = vim.schedule_wrap(function(fallback) -- Shift+Tab for previous item.
            if cmp.visible() then
              cmp.select_prev_item { behavior = cmp.SelectBehavior.Select } -- Select previous item.
            else
              fallback() -- Otherwise, execute fallback.
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources { -- Configure completion sources and their order/grouping.
          { name = 'copilot', group_index = 2 }, -- GitHub Copilot suggestions.
          { name = 'codeium', group_index = 2 }, -- Codeium suggestions.
          { name = 'nvim_lsp', group_index = 2 }, -- LSP completions.
          { name = 'luasnip', group_index = 2 }, -- Snippets from LuaSnip.
          { name = 'buffer', group_index = 2 }, -- Words from the current buffer.
          { name = 'path', group_index = 2 }, -- File system paths.
                                             -- `group_index = 2` implies these sources might be grouped together visually
                                             -- or in terms of priority, though priority is more explicitly handled by `sorting`.
        },
        formatting = { -- Configuration for how completion items are displayed.
          format = lspkind.cmp_format { -- Use lspkind to format items with icons and text.
            mode = 'symbol_text', -- Display mode: 'text', 'symbol', 'symbol_text'.
            maxwidth = 50, -- Maximum width of the completion item label.
            ellipsis_char = '...', -- Character used for ellipsis if the label exceeds maxwidth.
            show_labelDetails = true, -- If true, shows detailed label information if available.
            symbol_map = { Copilot = '', Codeium = '' }, -- Custom icons for specific completion kinds. (Nerd Font icons)
            before = function(entry, vim_item) -- Function to modify the item before display.
              -- Add a menu hint indicating the source of the completion.
              vim_item.menu = ({
                copilot = '[Copilot]',
                codeium = '[Codeium]',
                nvim_lsp = '[LSP]',
                luasnip = '[Snip]',
                buffer = '[Buf]',
                path = '[Path]',
              })[entry.source.name]
              return vim_item
            end,
          },
        },
        sorting = { -- Configuration for sorting completion items.
          priority_weight = 2, -- Default priority weight for sources.
          comparators = { -- A list of functions used to compare and sort completion items.
            require('copilot_cmp.comparators').prioritize, -- Custom comparator from copilot-cmp to prioritize its suggestions.
            cmp.config.compare.offset, -- Compares by offset from the typed text.
            cmp.config.compare.exact, -- Prioritizes exact matches.
            cmp.config.compare.score, -- Compares by a score (often from LSP).
            cmp.config.compare.recently_used, -- Prioritizes recently used items.
            cmp.config.compare.locality, -- Prioritizes items closer in the buffer.
            cmp.config.compare.kind, -- Compares by completion item kind.
            cmp.config.compare.sort_text, -- Compares by the text used for sorting.
            cmp.config.compare.length, -- Compares by length.
            cmp.config.compare.order, -- Original order from the source.
          },
        },
        experimental = { -- Experimental features.
          ghost_text = true, -- If true, shows an inline preview (ghost text) of the selected completion.
                             -- This is similar to Copilot's inline suggestions but for any cmp source.
        },
      }
    end,
  },
}
