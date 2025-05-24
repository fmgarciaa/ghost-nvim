-- This file configures the nvim-lualine/lualine.nvim plugin, which provides a
-- highly customizable statusline at the bottom of Neovim.

-- Load custom components for Lualine.
-- These are separate Lua modules that define specific parts of the statusline.
local mode = require 'plugins.appearance.lualine_comps.mode' -- Component to display the current mode (Normal, Insert, etc.).
local diff = require 'plugins.appearance.lualine_comps.diff' -- Component to show Git diff information (added, modified, removed lines).
local progress_file = require 'plugins.appearance.lualine_comps.progress' -- Component to display scroll progress through the current file.
local docker = require 'plugins.appearance.lualine_comps.docker' -- Component to show Docker status or context.
local lsp_status = require('plugins.appearance.lualine_comps.lsp_status').status -- Component for LSP (Language Server Protocol) status.
local lsp_progress = require 'plugins.appearance.lualine_comps.lsp_progress' -- Component for LSP progress (e.g., indexing).
local get_os = require('plugins.appearance.lualine_comps.get_os').status -- Component to display the operating system.
local copilot_status = require 'plugins.appearance.lualine_comps.copilot' -- Component for GitHub Copilot status.
local codeium_status = require 'plugins.appearance.lualine_comps.windsurf' -- Component for Codeium (Windsurf) status.

-- Return the plugin specification for lazy.nvim.
return {
  'nvim-lualine/lualine.nvim', -- The plugin's repository name.
  config = function() -- Function to run after the plugin is loaded.
    require('lualine').setup { -- Initialize Lualine with its configuration options.
      options = {
        globalstatus = true, -- If true, uses a single statusline for all windows (Neovim >= 0.7).
                             -- If false, each window has its own statusline.
        icons_enabled = true, -- If true, enables icons in Lualine components (requires a Nerd Font).
        theme = 'gruvbox', -- Sets the Lualine theme. Many themes are available, or 'auto' tries to match the colorscheme.
        section_separators = { left = '', right = '' }, -- Characters used as separators between Lualine sections. (Powerline-style icons)
        component_separators = { left = '|', right = '|' }, -- Characters used as separators between components within a section.
        disabled_filetypes = { 'alpha' }, -- List of filetypes for which Lualine will be disabled (e.g., dashboard).
        always_divide_middle = true, -- If true, ensures the middle sections (lualine_c, lualine_x) are always visually separated.
        ignore_focus = { 'neo-tree' }, -- List of buffer names or filetypes to ignore when checking focus for active/inactive statusline.
                                       -- Useful for plugin windows like Neo-tree that shouldn't make the main statusline inactive.
      },
      sections = { -- Defines the content of the active statusline, divided into sections (a, b, c, x, y, z).
        lualine_a = { mode }, -- Leftmost section: current mode.
        lualine_b = { -- Section b: Git branch and diff information.
          { 'branch', icon = { '' }, component_separators = { left = '|', right = '' } }, -- Git branch with an icon.
          diff, -- Custom diff component.
        },
        lualine_c = { -- Center section (left part): filename, filetype, encoding, filesize.
          { 'filename', path = 0 }, -- Filename. path = 0 shows only the filename, 1 shows relative path, etc.
          'filetype', -- Filetype.
          'encoding', -- File encoding.
          'filesize', -- File size.
        },
        lualine_x = { -- Center section (right part): diagnostics, fileformat.
          'diagnostics', -- LSP diagnostics summary (errors, warnings).
          { 'fileformat', icons_enabled = false }, -- File format (unix, dos, mac), icons disabled for this component.
        },
        lualine_y = { -- Section y: hostname, OS, LSP status, LSP progress.
          'hostname', -- System hostname.
          get_os, -- Custom OS component.
          lsp_status, -- Custom LSP status component.
          lsp_progress, -- Custom LSP progress component.
        },
        lualine_z = { -- Rightmost section: AI statuses, Docker, location, progress.
          copilot_status, -- Custom Copilot status.
          codeium_status, -- Custom Codeium status.
          docker, -- Custom Docker status.
          { 'location', padding = 0 }, -- Cursor location (line, column) with no padding.
          { progress_file, padding = 1 }, -- Custom file progress with padding.
        },
      },
      inactive_sections = { -- Defines the content of the statusline for inactive windows.
                            -- Typically simpler than the active statusline.
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 0 } }, -- Show only filename in inactive windows.
        lualine_x = { { 'location', padding = 0 } }, -- Show only location.
        lualine_y = {},
        lualine_z = {},
      },

      extensions = { 'fugitive', 'neo-tree' }, -- Enable Lualine extensions for specific plugins.
                                              -- 'fugitive': Provides Git status information.
                                              -- 'neo-tree': Provides information related to the Neo-tree file explorer.
    }
  end,
}
