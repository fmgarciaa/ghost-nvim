-- This file configures nvim-telescope/telescope.nvim, a highly extendable fuzzy finder
-- for Neovim. Telescope can search for files, buffers, Git items, LSP symbols, help tags,
-- and much more, with a previewer and integration with various other plugins.

-- Return the plugin specification for lazy.nvim.
return {
  'nvim-telescope/telescope.nvim', -- The plugin's repository name.
  event = 'VimEnter', -- Load Telescope when Neovim has fully started.
                      -- Can be deferred further (e.g., on first command/keymap) if startup time is critical.
  branch = '0.1.x', -- Specifies the version branch to use for stability.
  dependencies = { -- List of plugins that Telescope depends on or integrates with.
    'nvim-lua/plenary.nvim', -- Plenary provides utility functions used extensively by Telescope.
    {
      -- telescope-fzf-native.nvim provides an optional C backend for FZF (fuzzy finding algorithm),
      -- which can significantly speed up sorting and searching in Telescope.
      'nvim-telescope/telescope-fzf-native.nvim',
      -- Note: The original config had 'nvim-telescope/telescope-ui-select.nvim' listed here as well,
      -- which is unusual as a direct sub-dependency of fzf-native. It's listed again below.
      -- This build command compiles the C extension for fzf-native.
      build = 'make',
      -- This condition checks if 'make' is executable, only loading fzf-native if it can be built.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      -- telescope-ui-select.nvim provides an extension to use Telescope for UI selection prompts,
      -- for example, replacing `vim.ui.select()`.
      'nvim-telescope/telescope-ui-select.nvim'
    },
    {
      -- nvim-web-devicons provides icons for file types and other items in Telescope pickers.
      -- It's enabled only if `vim.g.have_nerd_font` is true (presumably set elsewhere).
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.have_nerd_font -- Assuming vim.g.have_nerd_font is set in the main config.
    },
  },
  config = function() -- Function to run after Telescope and its dependencies are loaded.
    -- General introduction and help information for Telescope (as comments).
    -- :Telescope help_tags
    -- Insert mode: <c-/> or Normal mode: ? for help within Telescope.

    -- Setup Telescope with global defaults and picker-specific configurations.
    require('telescope').setup {
      defaults = { -- Default settings applied to all Telescope pickers.
        -- `vimgrep_arguments` configures the command used by `live_grep` and `grep_string`.
        -- It uses 'rg' (ripgrep) with specific flags for consistent output and behavior.
        vimgrep_arguments = {
          'rg',
          '--color=never', -- Disable colors from rg, Telescope handles highlighting.
          '--no-heading', -- Suppress rg's own headings.
          '--with-filename', -- Include filename in output.
          '--line-number', -- Include line number.
          '--column', -- Include column number.
          '--smart-case', -- Case-insensitive unless uppercase letters are used in query.
          '--hidden', -- Search hidden files and directories.
        },
        mappings = { -- Default mappings within Telescope pickers.
          i = { -- Mappings for Insert mode in the Telescope prompt.
            ['<C-k>'] = require('telescope.actions').move_selection_previous, -- Move to the previous result.
            ['<C-j>'] = require('telescope.actions').move_selection_next, -- Move to the next result.
            ['<C-l>'] = require('telescope.actions').select_default, -- Open the selected item (default action).
                                                                     -- Note: <CR> (Enter) is usually the default for select_default.
                                                                     -- Overriding <C-l> might be for specific ergonomic reasons.
          },
          -- n = { -- Mappings for Normal mode in the Telescope results window can also be set.
          --   ['q'] = require('telescope.actions').close,
          -- }
        },
        -- Other defaults:
        -- layout_strategy = 'horizontal',
        -- layout_config = { preview_cutoff = 120, prompt_position = 'bottom' },
        -- sorting_strategy = 'ascending',
        -- scroll_strategy = 'cycle',
      },
      pickers = { -- Configuration specific to individual Telescope pickers.
        find_files = { -- For `builtin.find_files`.
          -- `file_ignore_patterns` lists patterns for files/directories to ignore.
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          hidden = true, -- Show hidden files (dotfiles) by default.
        },
        live_grep = { -- For `builtin.live_grep`.
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          -- `additional_args` can be a function to dynamically provide extra arguments to rg.
          additional_args = function(_)
            return { '--hidden' } -- Ensure hidden files are searched in live_grep as well.
          end,
        },
        -- Other pickers like 'buffers', 'git_commits' can be configured here too.
      },
      extensions = { -- Configuration for Telescope extensions.
        ['ui-select'] = { -- Settings for the telescope-ui-select.nvim extension.
                          -- Uses Telescope's dropdown theme for UI select prompts.
          require('telescope.themes').get_dropdown(),
        },
        -- fzf = { -- Configuration for fzf-native extension if needed.
        --   fuzzy = true, -- Use fzf's fuzzy matching.
        --   override_generic_sorter = true, -- Override Telescope's generic sorter.
        --   override_file_sorter = true, -- Override Telescope's file sorter.
        --   case_mode = "smart_case",
        -- }
      },
    }

    -- Attempt to load Telescope extensions.
    -- `pcall` (protected call) is used to prevent errors if an extension isn't installed.
    pcall(require('telescope').load_extension, 'fzf') -- Load fzf-native extension.
    pcall(require('telescope').load_extension, 'ui-select') -- Load ui-select extension.

    -- Get a reference to Telescope's built-in pickers.
    local builtin = require 'telescope.builtin'
    local keymap = vim.keymap.set -- Shorthand for vim.keymap.set.

    -- Define key mappings in Normal mode to trigger various Telescope pickers.
    -- Each mapping has a description for display with plugins like which-key.
    keymap('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    keymap('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    keymap('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    keymap('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope (list all built-in pickers)' })
    keymap('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord (under cursor)' })
    keymap('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep (search text in project)' })
    keymap('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics (LSP diagnostics)' })
    keymap('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume (reopen last Telescope picker)' })
    keymap('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    keymap('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' }) -- Double <leader> for buffers.

    -- Example of a more advanced keymap for current buffer fuzzy search with a custom theme.
    keymap('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10, -- Transparency for the dropdown window.
        previewer = false, -- Disable the previewer for this specific picker.
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Example of passing options directly to a built-in picker.
    keymap('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true, -- Search only in open files.
        prompt_title = 'Live Grep in Open Files', -- Custom prompt title.
      }
    end, { desc = '[F]ind [/] in Open Files' })
  end,
}
