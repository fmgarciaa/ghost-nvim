local lsp_spinner = {
  'lsp_progress',
  display_components = { 'lsp_client_name', 'spinner' },
  separators = {
    spinner = { pre = '', post = '' },
    lsp_client_name = { pre = '[', post = ']' },
  },
  timer = {
    spinner = 150,
    progress_enddelay = 2500,
    lsp_client_name_enddelay = 1000,
  },
  spinner_symbols = { '', '', '', '', '', '' },
}

return lsp_spinner
