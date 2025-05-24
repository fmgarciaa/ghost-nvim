-- This file configures the nvim-neo-tree/neo-tree.nvim plugin, a file explorer
-- that can also display buffers, Git status, and document symbols.

-- Return the plugin specification for lazy.nvim.
return {
  'nvim-neo-tree/neo-tree.nvim', -- The plugin's repository name.
  branch = 'v3.x', -- Specifies the version branch to use.
  dependencies = { -- List of plugins that Neo-tree depends on or integrates with.
    'nvim-lua/plenary.nvim', -- Provides utility functions.
    'nvim-tree/nvim-web-devicons', -- Provides file type icons.
    'MunifTanjim/nui.nvim', -- Provides UI components used by Neo-tree.
    '3rd/image.nvim', -- Optional: Adds image preview support in Neo-tree's preview window.
    {
      -- nvim-window-picker is used by Neo-tree for some 'open_with_window_picker' actions.
      's1n7ax/nvim-window-picker',
      version = '2.*', -- Specify version for compatibility.
      config = function()
        require('window-picker').setup {
          filter_rules = { -- Rules for filtering windows shown by the picker.
            include_current_win = false, -- Don't include the current window in picker choices.
            autoselect_one = true, -- If only one window matches, select it automatically.
            bo = { -- Filter based on buffer options.
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' }, -- Ignore windows with these filetypes.
              buftype = { 'terminal', 'quickfix' }, -- Ignore windows with these buffer types.
            },
          },
        }
      end,
    },
  },
  config = function() -- Function to run after the plugin is loaded.
    -- Define diagnostic signs if not already defined elsewhere.
    -- These icons are used to indicate errors, warnings, etc., next to file names.
    -- Requires a Nerd Font for the icons.
    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

    require('neo-tree').setup { -- Initialize Neo-tree with its configuration options.
      -- sources: Defines the types of trees Neo-tree can display.
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      source_selector = { -- Configuration for the source selector UI (tabs at the top of Neo-tree).
        winbar = true, -- Show the source selector in the Neo-tree winbar.
        content_layout = 'center', -- Layout of items in the selector.
        sources = { -- Display names and icons for each source.
          { source = 'filesystem', display_name = '󰉓 Files' },
          { source = 'buffers', display_name = ' Buffers' },
          { source = 'git_status', display_name = ' Git' },
          { source = 'document_symbols', display_name = '󰈙 Symbols' },
        },
      },
      close_if_last_window = true, -- Close Neo-tree if it's the last window remaining in a tab.
      popup_border_style = 'rounded', -- Border style for floating windows used by Neo-tree.
      enable_git_status = true, -- Enable Git status decorations in the filesystem tree.
      enable_diagnostics = true, -- Enable diagnostic decorations.
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- Filetypes/buftypes of windows that Neo-tree won't replace when opening a file.
      sort_case_insensitive = false, -- Whether to sort files and directories case-insensitively.
      -- sort_function = nil, -- Custom sort function can be provided here.
      default_component_configs = { -- Default configurations for various UI components of tree nodes.
        container = { enable_character_fade = true }, -- Fade overflowing text in the container.
        indent = { -- Indentation style.
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          with_expanders = nil, -- nil means auto: enable if file_nesting is on.
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = { -- File and folder icons.
          folder_closed = '',
          folder_open = '',
          folder_empty = '󰷏',
          default = '*', -- Fallback icon.
          highlight = 'NeoTreeFileIcon',
        },
        modified = { symbol = '[+]', highlight = 'NeoTreeModified' }, -- Symbol for modified files.
        name = { -- File/directory name display.
          trailing_slash = false, -- Don't add a trailing slash to directory names.
          use_git_status_colors = true, -- Color names based on Git status.
          highlight = 'NeoTreeFileName',
        },
        git_status = { -- Symbols for Git status.
          symbols = {
            added = '󰝒',
            modified = '',
            deleted = '✖',
            renamed = '󰁕',
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
        -- Columns for file metadata (can be disabled individually).
        file_size = { enabled = true, required_width = 64 },
        type = { enabled = true, required_width = 122 },
        last_modified = { enabled = true, required_width = 88 },
        created = { enabled = true, required_width = 110 },
        symlink_target = { enabled = false },
      },
      commands = {}, -- Global custom commands can be defined here.
      window = { -- General window settings for Neo-tree.
        position = 'right', -- Default position ('left', 'right', 'float', 'current').
        width = 40, -- Width of the Neo-tree window.
        mapping_options = { noremap = true, nowait = true }, -- Default options for mappings.
        mappings = { -- Key mappings for when the Neo-tree window is active.
          ['<space>'] = { 'toggle_node', nowait = false }, -- Toggle expand/collapse node.
          ['<2-LeftMouse>'] = 'open',
          ['<cr>'] = 'open',
          ['<esc>'] = 'cancel', -- Close preview or floating Neo-tree.
          ['P'] = { 'toggle_preview', config = { use_float = true } }, -- Toggle floating preview.
          ['l'] = 'open', -- 'l' or right arrow typically opens a file or expands a dir.
          ['S'] = 'open_split', -- Open in horizontal split.
          ['s'] = 'open_vsplit', -- Open in vertical split.
          ['t'] = 'open_tabnew', -- Open in a new tab.
          ['w'] = 'open_with_window_picker', -- Open with window picker.
          ['C'] = 'close_node', -- Close current node.
          ['z'] = 'close_all_nodes', -- Close all nodes.
          ['a'] = { 'add', config = { show_path = 'none' } }, -- Add file/directory.
          ['A'] = 'add_directory', -- Add directory.
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy', -- Copy file/directory.
          ['m'] = 'move', -- Move file/directory.
          ['q'] = 'close_window', -- Close Neo-tree window.
          ['R'] = 'refresh',
          ['?'] = 'show_help', -- Show help popup.
          ['<'] = 'prev_source', -- Switch to previous source (Files, Buffers, Git).
          ['>'] = 'next_source', -- Switch to next source.
          ['i'] = 'show_file_details', -- Show file details.
        },
      },
      nesting_rules = {}, -- Rules for nesting files (e.g., .js under .html).
      filesystem = { -- Settings specific to the 'filesystem' source.
        filtered_items = { -- How to handle filtered/hidden items.
          visible = false, -- If true, hidden items are shown but grayed out.
          hide_dotfiles = false, -- If true, hides dotfiles (e.g., .gitconfig).
          hide_gitignored = false, -- If true, hides files/folders ignored by .gitignore.
          hide_hidden = false, -- If true, hides files with the 'hidden' attribute (Windows).
          hide_by_name = { -- List of filenames to always hide.
            '.DS_Store',
            'thumbs.db',
            'node_modules',
            '__pycache__',
            '.virtual_documents',
            '.git',
            '.python-version',
            '.venv',
          },
          hide_by_pattern = {}, -- Glob patterns for files/folders to hide.
          always_show = {}, -- Items to always show, even if other rules would hide them.
          never_show = {}, -- Items to never show, overrides always_show.
          never_show_by_pattern = {}, -- Glob patterns for items to never show.
        },
        follow_current_file = { -- Whether Neo-tree should automatically reveal the current buffer's file.
          enabled = false,
          leave_dirs_open = false, -- If true, auto-expanded directories remain open.
        },
        group_empty_dirs = false, -- If true, empty directories are grouped together.
        hijack_netrw_behavior = 'open_default', -- How Neo-tree interacts with Netrw (built-in file explorer).
                                             -- 'open_default': Disables Netrw and opens dirs in Neo-tree.
        use_libuv_file_watcher = false, -- Use OS-level file watchers for faster updates (experimental).
        window = { -- Mappings specific to the 'filesystem' source.
          mappings = {
            ['<bs>'] = 'navigate_up', -- Go to parent directory.
            ['.'] = 'set_root', -- Set current directory as tree root.
            ['H'] = 'toggle_hidden', -- Toggle visibility of hidden files.
            ['/'] = 'fuzzy_finder', -- Fuzzy find files in the current tree.
            ['D'] = 'fuzzy_finder_directory', -- Fuzzy find directories.
            ['#'] = 'fuzzy_sorter', -- Fuzzy sort items.
            ['f'] = 'filter_on_submit', -- Apply filter.
            ['<c-x>'] = 'clear_filter', -- Clear filter.
            ['[g'] = 'prev_git_modified', -- Go to previous Git modified item.
            [']g'] = 'next_git_modified', -- Go to next Git modified item.
            -- Mappings for sorting files/directories.
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created', nowait = false },
            ['od'] = { 'order_by_diagnostics', nowait = false },
            ['og'] = { 'order_by_git_status', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
            ['on'] = { 'order_by_name', nowait = false },
            ['os'] = { 'order_by_size', nowait = false },
            ['ot'] = { 'order_by_type', nowait = false },
          },
          fuzzy_finder_mappings = { -- Mappings for the fuzzy finder popup.
            ['<down>'] = 'move_cursor_down',
            ['<C-n>'] = 'move_cursor_down',
            ['<up>'] = 'move_cursor_up',
            ['<C-p>'] = 'move_cursor_up',
          },
        },
        commands = {}, -- Filesystem-specific custom commands.
      },
      buffers = { -- Settings specific to the 'buffers' source.
        follow_current_file = { enabled = true, leave_dirs_open = false },
        group_empty_dirs = true,
        show_unloaded = true, -- Show unloaded buffers.
        window = { -- Mappings specific to the 'buffers' source.
          mappings = {
            ['bd'] = 'buffer_delete', -- Delete buffer.
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
            -- Sorting mappings (similar to filesystem).
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created', nowait = false },
            ['od'] = { 'order_by_diagnostics', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
            ['on'] = { 'order_by_name', nowait = false },
            ['os'] = { 'order_by_size', nowait = false },
            ['ot'] = { 'order_by_type', nowait = false },
          },
        },
      },
      git_status = { -- Settings specific to the 'git_status' source.
        window = {
          position = 'right', -- Default position for git_status source, can be float.
          mappings = { -- Mappings for Git actions.
            ['A'] = 'git_add_all',
            ['gu'] = 'git_unstage_file',
            ['ga'] = 'git_add_file',
            ['gr'] = 'git_revert_file',
            ['gc'] = 'git_commit',
            ['gp'] = 'git_push',
            ['gg'] = 'git_commit_and_push',
            -- Sorting mappings (similar to filesystem).
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created', nowait = false },
            ['od'] = { 'order_by_diagnostics', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
            ['on'] = { 'order_by_name', nowait = false },
            ['os'] = { 'order_by_size', nowait = false },
            ['ot'] = { 'order_by_type', nowait = false },
          },
        },
      },
    }

    -- General keymaps for Neo-tree.
    local keymap = vim.keymap.set
    -- Toggle Neo-tree on the right side.
    keymap('n', '<leader>e', ':Neotree toggle position=right<CR>', { noremap = true, silent = true })
    -- Show Git status in a floating Neo-tree window.
    keymap('n', '<leader>ngs', ':Neotree float git_status<CR>', { noremap = true, silent = true, desc = 'Show git status in float Neo-tree popup' })
  end,
}
