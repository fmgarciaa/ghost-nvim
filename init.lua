require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets
require 'core.globals' -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins Setup
require('lazy').setup({
  -- Load plugins from lua directory
  { import = 'plugins' },
  { import = 'plugins.lsp' },
  { import = 'plugins.ui' },
  { import = 'plugins.themes' },
  { import = 'plugins.ai' },
  -- { import = "dap" },
}, {
  change_detection = {
    notify = false,
  },
})

require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets
require 'core.globals' -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

--Plugins Setup
require('lazy').setup('plugins', {
  change_detection = {
    notify = false,
  },
})

-- Detect system type and configure clipboard accordingly
if vim.fn.has 'wsl' == 1 then
  -- WSL specific settings
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = '/mnt/c/Windows/System32/clip.exe',
      ['*'] = '/mnt/c/Windows/System32/clip.exe',
    },
    paste = {
      ['+'] = '/mnt/c/Windows/System32/clip.exe -o',
      ['*'] = '/mnt/c/Windows/System32/clip.exe -o',
    },
    cache_enabled = 0,
  }
elseif vim.fn.has 'macunix' == 1 then
  -- macOS specific settings
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
else
  -- Default clipboard settings for other systems (if needed)
  vim.g.clipboard = {
    name = 'default',
    copy = {
      ['+'] = 'xclip -selection clipboard',
      ['*'] = 'xclip -selection primary',
    },
    paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection primary -o',
    },
    cache_enabled = 0,
  }
end
