-- This file configures the akinsho/bufferline.nvim plugin, which provides an improved
-- tabline (buffer line) at the top of Neovim, showing open buffers.

-- Return the plugin specification for lazy.nvim.
return {
  'akinsho/bufferline.nvim', -- The plugin's repository name.
  dependencies = { -- List of plugins that bufferline.nvim depends on or integrates with.
    'moll/vim-bbye', -- Used for a more robust buffer closing command (Bdelete).
    'nvim-tree/nvim-web-devicons', -- Provides icons for file types in the bufferline.
  },
  config = function() -- Function to run after the plugin is loaded.
    require('bufferline').setup { -- Initialize the plugin with its configuration options.
      options = {
        mode = 'buffers', -- Display open buffers. Can be set to "tabs" to show Neovim's native tabs.
        themable = true, -- Allows the bufferline's highlight groups to be overridden by themes.
        numbers = 'none', -- How to display buffer numbers: "none", "ordinal", "buffer_id", "both", or a custom function.
        close_command = 'Bdelete! %d', -- Command to close a buffer. '%d' is replaced by the buffer number.
                                      -- Uses Bdelete from moll/vim-bbye for smarter closing.
        buffer_close_icon = '✗', -- Icon shown on each buffer for closing it.
        close_icon = '✗', -- Icon shown on the far right of the bufferline for closing the current buffer.
        path_components = 1, -- Number of directory components to show in the buffer path. 1 means only filename.
                             -- e.g., for "src/utils/helpers.lua", 1 shows "helpers.lua", 2 shows "utils/helpers.lua".
        modified_icon = '●', -- Icon to indicate a modified (unsaved) buffer.
        left_trunc_marker = '', -- Marker shown when the left side of the buffer name is truncated. (Icon requires Nerd Font)
        right_trunc_marker = '', -- Marker shown when the right side of the buffer name is truncated. (Icon requires Nerd Font)
        max_name_length = 30, -- Maximum length of a buffer name before truncation.
        max_prefix_length = 30, -- Maximum length of the prefix shown when a buffer name is de-duplicated (e.g., if multiple files with the same name are open).
        tab_size = 21, -- The width allocated for each buffer tab in the bufferline.
        diagnostics = false, -- Set to true or "nvim_lsp" to show diagnostic indicators (errors, warnings) in the bufferline.
                             -- Disabled here, possibly handled by lualine or other plugins.
        diagnostics_update_in_insert = false, -- If diagnostics are enabled, whether to update them in Insert mode.
        color_icons = true, -- If true, file type icons will be colored according to their definition.
        show_buffer_icons = true, -- If true, display file type icons next to buffer names.
        show_buffer_close_icons = true, -- If true, show the close icon on each buffer tab.
        show_close_icon = true, -- If true, show the global close icon on the right.
        persist_buffer_sort = true, -- If true, custom sorted buffers will maintain their order across sessions.
        separator_style = { '│', '│' }, -- Style of the separator between buffer tabs. Can be "thick", "thin", or custom characters for left and right.
        enforce_regular_tabs = true, -- If true, ensures that bufferline tabs behave more like traditional GUI tabs.
        always_show_bufferline = true, -- If true, the bufferline is always visible, even with only one buffer.
                                       -- If false, it might hide with a single buffer.
        show_tab_indicators = false, -- If true, shows indicators for Neovim's native tabs (if mode is "tabs").
        indicator = { -- Configuration for the indicator of the currently active buffer.
          icon = '▍', -- Icon used for the indicator. (Icon requires Nerd Font)
          style = 'icon', -- Style of the indicator: "icon", "underline", or "none".
        },
        icon_pinned = '󰐃', -- Icon for a pinned buffer. (Icon requires Nerd Font)
        minimum_padding = 1, -- Minimum padding on the left and right of the bufferline.
        maximum_padding = 5, -- Maximum padding.
        maximum_length = 15, -- Seems to be a duplicate or alternative to max_name_length, context might clarify.
                             -- Likely refers to the maximum length of the displayed name for a single buffer.
        sort_by = 'insert_at_end', -- How new buffers are sorted: 'insert_at_end', 'insert_at_start', 'id', 'extension', 'relative_directory', 'directory', or a custom function.
      },
      highlights = { -- Custom highlight group overrides for the bufferline.
        separator = { -- Highlight for the separators between buffers.
          fg = '#434C5E', -- Sets the foreground color.
        },
        buffer_selected = { -- Highlight for the selected (active) buffer.
          bold = true,
          italic = false,
        },
        -- Other highlight groups that can be customized (commented out here):
        -- separator_selected = {}, -- Separator next to the selected buffer.
        -- tab_selected = {}, -- If using "tabs" mode, the selected tab.
        -- background = {}, -- Background of the bufferline.
        -- indicator_selected = {}, -- The selected buffer's indicator.
        -- fill = {}, -- The empty space in the bufferline.
      },
    }
  end,
}
