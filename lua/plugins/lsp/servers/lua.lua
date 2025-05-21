-- ~/.config/nvim/lua/lsp/servers/lua.lua

-- Configuration for Lua server (lua_ls)
require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false, -- Disable third-party library checking
      },
      format = {
        enable = false, -- Disable formatting by lua_ls
      },
    },
  },
}
