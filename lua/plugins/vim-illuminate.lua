return {
  'RRethy/vim-illuminate',
  event = 'BufReadPost',
  config = function()
    vim.g.Illuminate_delay = 100
    vim.g.Illuminate_highlightUnderCursor = 0
    vim.g.Illuminate_ftblacklist = {}

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        require('illuminate').on_attach(client, bufnr)
      end,
    })

    -- Optional: add highlight to verify it's working visually
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = '#3b4252' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = '#3b4252' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = '#3b4252' })
  end,
}
