local mode = require 'plugins.ui.lualine_comps.mode'
local diff = require 'plugins.ui.lualine_comps.diff'
local progress_file = require 'plugins.ui.lualine_comps.progress'
local docker = require 'plugins.ui.lualine_comps.docker'
local lsp_status = require('plugins.ui.lualine_comps.lsp_status').status
local lsp_progress = require 'plugins.ui.lualine_comps.lsp_progress'
local get_os = require('plugins.ui.lualine_comps.get_os').status
local copilot_status = require 'plugins.ui.lualine_comps.copilot'
local codeium_status = require 'plugins.ui.lualine_comps.windsurf'

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
        lualine_c = { { 'filename', path = 1 }, 'filetype', 'encoding', 'filesize' },
        lualine_x = { 'diagnostics', { 'fileformat', icons_enabled = false } },
        lualine_y = { 'hostname', get_os, lsp_status, lsp_progress },
        lualine_z = { copilot_status, codeium_status.status, docker, 'location', progress_file },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },

      extensions = { 'fugitive', 'neo-tree' },
    }
  end,
}
