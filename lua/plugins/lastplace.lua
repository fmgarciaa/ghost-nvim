-- Restore cursor position when reopening files
return {
  'farmergreg/vim-lastplace',
  opts = {}, -- No extensive configuration needed
  config = function()
    -- Ignore certain buffer types and file types
    vim.g.lastplace_ignore_buftype = 'quickfix,nofile,help'
    vim.g.lastplace_ignore_filetype = 'gitcommit,gitrebase,svn,hgcommit'
    vim.g.lastplace_open_folds = 1 -- Open folds when restoring cursor position
  end,
}
