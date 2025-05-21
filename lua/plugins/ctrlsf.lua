-- Advanced search and replace in multiple files
return {
  'dyng/ctrlsf.vim',
  opts = {}, -- No extensive configuration needed
  config = function()
    vim.g.ctrlsf_ackprg = 'rg --vimgrep --hidden'
    vim.g.ctrlsf_default_root = 'project'
    vim.g.ctrlsf_case_sensitive = 'smart'
    vim.g.ctrlsf_auto_close = 1
    vim.g.ctrlsf_position = 'left'
    vim.g.ctrlsf_winsize = '35%'
    vim.g.ctrlsf_context = '-C 3'
    vim.g.ctrlsf_ignore_dir = {
      'node_modules',
      '.git',
      'dist',
      '__pycache__',
      '.mypy_cache',
      '.pytest_cache',
      '.venv',
      'env',
      'venv',
    }

    -- Keymaps for CtrlSF
    local keymap = vim.keymap.set
    keymap({ 'n', 'i' }, '<C-f>f', ':CtrlSF ', { noremap = true, silent = true, desc = 'Start a search' })
    keymap('n', '<C-f>c', ':CtrlSFClose<CR>', { noremap = true, silent = true, desc = 'Close search window' })
  end,
}
