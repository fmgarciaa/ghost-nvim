local mode = require 'plugins.appearance.lualine_comps.mode'
local diff = require 'plugins.appearance.lualine_comps.diff'
local progress_file = require 'plugins.appearance.lualine_comps.progress'
local docker = require 'plugins.appearance.lualine_comps.docker'
local lsp_status = require('plugins.appearance.lualine_comps.lsp_status').status
local lsp_progress = require 'plugins.appearance.lualine_comps.lsp_progress'
local get_os = require('plugins.appearance.lualine_comps.get_os').status
local copilot_status = require 'plugins.appearance.lualine_comps.copilot'
local codeium_status = require 'plugins.appearance.lualine_comps.windsurf'

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = 'gruvbox',
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        disabled_filetypes = { 'alpha' },
        always_divide_middle = true,
        ignore_focus = { 'neo-tree' },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { { 'branch', icon = { '' }, component_separators = { left = '|', right = '' } }, diff },
        lualine_c = { { 'filename', path = 0 }, 'filetype', 'encoding', 'filesize' },
        lualine_x = { 'diagnostics', { 'fileformat', icons_enabled = false } },
        lualine_y = { 'hostname', get_os, lsp_status, lsp_progress },
        lualine_z = { copilot_status, codeium_status, docker, { 'location', padding = 0 }, { progress_file, padding = 1 } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 0 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },

      extensions = { 'fugitive', 'neo-tree' },
    }
  end,
}
