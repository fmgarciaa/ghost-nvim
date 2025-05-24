-- This file configures the RRethy/vim-illuminate plugin, which highlights
-- other instances of the word under the cursor, similar to features in IDEs.

-- Return the plugin specification for lazy.nvim.
return {
  'RRethy/vim-illuminate', -- The plugin's repository name.
  event = 'BufReadPost', -- Load the plugin after a buffer has been read and syntax processing is done.
                         -- This ensures that Treesitter (if used for illumination) is ready.
                         -- 'BufEnter' or 'VeryLazy' could also be options depending on desired responsiveness.
  config = function() -- Function to run after the plugin is loaded.
    -- Global configuration variables for vim-illuminate.
    -- These are traditional Vimscript global variables, prefixed with 'g:'.
    vim.g.Illuminate_delay = 100 -- Delay in milliseconds before highlighting instances.
                                 -- A small delay can prevent performance issues while typing quickly.

    vim.g.Illuminate_highlightUnderCursor = 0 -- If 1 (or true), also highlights the word directly under the cursor.
                                            -- Set to 0 (or false) to only highlight *other* instances.

    vim.g.Illuminate_ftblacklist = {} -- A list (Lua table, Vim dictionary) of filetypes to disable illumination for.
                                      -- Example: { 'help', 'packer' }

    -- Autocommand to integrate vim-illuminate with the Language Server Protocol (LSP).
    -- This allows illuminate to use LSP's document highlighting capabilities, which can be
    -- more context-aware (e.g., distinguishing variables with the same name in different scopes).
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        -- This callback function is executed when an LSP client attaches to a buffer.
        local client = vim.lsp.get_client_by_id(args.data.client_id) -- Get the LSP client object.
        local bufnr = args.buf -- Get the buffer number the LSP client attached to.
        -- Call illuminate's on_attach function to enable LSP-driven highlighting for this client and buffer.
        require('illuminate').on_attach(client, bufnr)
      end,
    })

    -- Optional: Define custom highlight groups for illuminated words.
    -- This allows you to control the appearance of the highlights.
    -- If these are not set, vim-illuminate uses default linking to existing highlight groups.
    -- The colors used here ('#3b4252') are a dark grey, suitable for a subtle highlight.
    -- You would typically adjust these to match your colorscheme.
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = '#3b4252' }) -- Highlight for general instances (text).
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = '#3b4252' }) -- Highlight for read access instances.
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = '#3b4252' }) -- Highlight for write access instances.
  end,
}
