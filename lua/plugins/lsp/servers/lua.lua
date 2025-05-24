-- This file configures the lua-language-server (lua_ls), which provides
-- LSP features for Lua, such as diagnostics, completion, and hover information.
-- The configuration is done via nvim-lspconfig.

-- Get the lspconfig module.
local lspconfig = require('lspconfig')

-- Setup for lua_ls.
lspconfig.lua_ls.setup {
  -- `settings` allows passing configuration directly to the language server.
  -- These settings are specific to lua_ls.
  settings = {
    Lua = { -- Settings under the "Lua" namespace are for lua_ls.
      diagnostics = {
        -- Defines global variables that lua_ls should not warn about as undefined.
        -- This is crucial for Neovim Lua configuration, where 'vim' is a global.
        globals = { 'vim' },
      },
      workspace = {
        -- `checkThirdParty = false` disables lua_ls from checking or indexing
        -- third-party libraries in the workspace (e.g., from 'lua_modules' or similar).
        -- This can improve performance, especially in large projects or when using
        -- libraries not strictly part of the current project's direct source.
        -- Set to `true` if you want diagnostics and completions from such libraries.
        checkThirdParty = false,
      },
      format = {
        -- `enable = false` disables lua_ls's built-in formatter.
        -- This is often done if another formatter (like stylua via none-ls) is preferred.
        -- If set to `true`, lua_ls would provide formatting capabilities.
        enable = false,
      },
      -- Other potential lua_ls settings:
      -- completion = { callSnippet = "Replace" }, -- How snippets from completions are handled.
      -- telemetry = { enable = false }, -- Disable telemetry.
      -- runtime = { version = "LuaJIT" }, -- Specify Lua runtime version.
    },
  },
  -- The `on_attach` function and `capabilities` are typically inherited from the
  -- global LSP setup in `lua/plugins/lsp/lsp.lua`. If server-specific `on_attach`
  -- behavior or capabilities were needed, they would be defined here.
  -- For example:
  -- on_attach = function(client, bufnr)
  --   -- Custom on_attach logic for lua_ls
  -- end,
  -- capabilities = custom_capabilities_for_lua_ls,
}
