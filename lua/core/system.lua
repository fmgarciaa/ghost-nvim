-- This file handles system-specific configurations, primarily focusing on clipboard integration.
-- It detects the operating system environment (WSL, macOS, or other Linux/Unix)
-- and sets up the appropriate clipboard provider.

-- Detect if Neovim is running in Windows Subsystem for Linux (WSL).
if vim.fn.has 'wsl' == 1 then
  -- WSL specific clipboard configuration.
  -- Uses 'win32yank.exe' to interact with the Windows clipboard.
  vim.g.clipboard = {
    name = 'win32yank-wsl', -- A name for this clipboard configuration.
    copy = {
      -- Command to copy to the system clipboard (+ register) or primary selection (* register).
      -- 'win32yank.exe -i --crlf' reads from stdin and copies with CRLF line endings (Windows style).
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      -- Command to paste from the system clipboard (+ register) or primary selection (* register).
      -- 'win32yank.exe -o --lf' writes to stdout with LF line endings (Unix style).
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0, -- Disables clipboard caching. 0 means false.
  }
-- Detect if Neovim is running on macOS.
elseif vim.fn.has 'macunix' == 1 then
  -- macOS specific clipboard configuration.
  -- Uses the built-in 'pbcopy' and 'pbpaste' command-line utilities.
  vim.g.clipboard = {
    name = 'macOS-clipboard', -- A name for this clipboard configuration.
    copy = {
      ['+'] = 'pbcopy', -- 'pbcopy' reads from stdin and copies to the system clipboard.
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste', -- 'pbpaste' writes the clipboard content to stdout.
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0, -- Disables clipboard caching.
  }
else
  -- Default clipboard configuration for other systems (typically Linux/Unix).
  -- Uses 'xclip' utility. This might require 'xclip' to be installed on the system.
  vim.g.clipboard = {
    name = 'default', -- A name for this clipboard configuration.
    copy = {
      -- 'xclip -selection clipboard' copies to the system clipboard.
      -- 'xclip -selection primary' copies to the X11 primary selection (middle-mouse paste).
      ['+'] = 'xclip -selection clipboard',
      ['*'] = 'xclip -selection primary',
    },
    paste = {
      -- 'xclip -selection clipboard -o' pastes from the system clipboard.
      -- 'xclip -selection primary -o' pastes from the X11 primary selection.
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection primary -o',
    },
    cache_enabled = 0, -- Disables clipboard caching.
  }
end
