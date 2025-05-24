-- This file configures the Language Server Protocol (LSP) client for Neovim,
-- primarily using neovim/nvim-lspconfig. It also sets up mason.nvim for
-- managing LSP servers, formatters, and linters.

-- Return the plugin specification for lazy.nvim.
return {
  {
    'neovim/nvim-lspconfig', -- The core LSP client configuration plugin.
    event = 'BufReadPre', -- Load LSP config early when a buffer is read.
                          -- This ensures LSP features are available quickly for opened files.
    dependencies = { -- List of dependencies for nvim-lspconfig.
      { 'williamboman/mason.nvim', version = '1.11.0' }, -- Mason: A package manager for LSPs, DAP servers, linters, formatters.
      { 'williamboman/mason-lspconfig.nvim', version = '1.32.0' }, -- Mason-lspconfig: Integrates Mason with nvim-lspconfig
                                                                -- to simplify LSP server setup.
      -- Other dependencies like nvim-navic for breadcrumbs are often included here if directly used by on_attach.
    },
    config = function() -- Function to run after the plugin and its dependencies are loaded.
      -- Get default LSP capabilities and enhance them with cmp-nvim-lsp capabilities.
      -- This ensures that the LSP client reports capabilities compatible with nvim-cmp.
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Custom function to filter diagnostics, specifically for Pyright.
      -- This function returns `false` for diagnostics that should be ignored.
      local function filter_diagnostics(diagnostic)
        if diagnostic.source == 'Pyright' then
          -- Ignore specific Pyright warnings/info messages.
          return not (
            diagnostic.message:match 'is not accessed' -- e.g., "variable is not accessed"
            or diagnostic.message:match 'could not be resolved' -- e.g., "import X could not be resolved" (can be noisy)
            or diagnostic.message:match 'Expression value is unused'
          )
        end
        return true -- Keep all other diagnostics.
      end

      -- Override the global 'textDocument/publishDiagnostics' handler.
      -- This allows intercepting and modifying diagnostics before they are processed by Neovim.
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(function(_, params, ...)
        -- Filter the diagnostics using the custom function.
        params.diagnostics = vim.tbl_filter(filter_diagnostics, params.diagnostics)
        -- Call the original diagnostics handler with the (potentially modified) params.
        vim.lsp.diagnostic.on_publish_diagnostics(_, params, ...)
      end, {})

      -- Configuration for Neovim's built-in LSP diagnostics UI.
      vim.diagnostic.config {
        virtual_text = { -- Configuration for virtual text (inline diagnostic messages).
          prefix = '~', -- Character prefix for virtual text.
          spacing = 4, -- Spacing around the virtual text.
          source = 'if_many', -- Show source only if there are multiple diagnostic sources. 'always' or 'never'.
          format = function(diagnostic) -- Custom formatting for virtual text.
            return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source or 'unknown', diagnostic.code or '')
          end,
        },
        signs = { -- Configuration for diagnostic signs in the signcolumn.
          text = { -- Nerd Font icons for different severity levels.
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
        underline = { -- Configuration for underlining diagnostics.
          severity = { min = vim.diagnostic.severity.WARN }, -- Minimum severity to underline (e.g., only underline warnings and errors).
        },
        update_in_insert = false, -- Do not update diagnostics while in Insert mode (can be distracting).
        severity_sort = true, -- Sort diagnostics by severity.
        float = { -- Configuration for the floating window that shows diagnostic details on hover.
          border = 'rounded', -- Border style for the float.
          source = 'always', -- Always show the source of the diagnostic.
          format = function(diagnostic) -- Custom formatting for the floating window.
            return string.format('%s\n\n%s: %s', diagnostic.message, diagnostic.source or 'unknown', diagnostic.code or '')
          end,
          header = { ' Diagnostics:', 'DiagnosticHeader' }, -- Header for the float (Icon + Text, Highlight group).
          prefix = function(diagnostic) -- Prefix icon based on severity for the float.
            local icons = {
              [vim.diagnostic.severity.ERROR] = ' ',
              [vim.diagnostic.severity.WARN] = ' ',
              [vim.diagnostic.severity.INFO] = ' ',
              [vim.diagnostic.severity.HINT] = ' ',
            }
            return icons[diagnostic.severity] or ''
          end,
        },
      }

      -- Set custom highlight colors for diagnostic severity levels.
      -- These colors are applied to the diagnostic signs and virtual text.
      local diagnostic_colors = {
        DiagnosticError = '#F44747', -- Red for errors.
        DiagnosticWarn = '#FFCC00', -- Yellow for warnings.
        DiagnosticInfo = '#75BEFF', -- Blue for info.
        DiagnosticHint = '#4EC9B0', -- Cyan/Teal for hints.
      }
      for group, color in pairs(diagnostic_colors) do
        vim.api.nvim_set_hl(0, group, { fg = color }) -- `0` for global namespace.
      end

      -- Set custom highlight attributes for diagnostic underlining.
      local diagnostic_underline = {
        DiagnosticUnderlineError = { undercurl = true, sp = '#F44747' }, -- Undercurl with red color for errors.
        DiagnosticUnderlineWarn = { undercurl = true, sp = '#FFCC00' }, -- Undercurl with yellow for warnings.
        DiagnosticUnderlineInfo = { undercurl = true, sp = '#75BEFF' }, -- Undercurl with blue for info.
        DiagnosticUnderlineHint = { undercurl = true, sp = '#4EC9B0' }, -- Undercurl with cyan/teal for hints.
      }
      for group, attrs in pairs(diagnostic_underline) do
        vim.api.nvim_set_hl(0, group, attrs)
      end

      -- `on_attach` function: Executed when an LSP client attaches to a buffer.
      -- Used to set buffer-local keymaps and options related to LSP.
      local function on_attach(client, bufnr)
        -- Disable formatting capability for 'sqls' LSP client if 'null-ls' is intended to handle SQL formatting.
        if client.name == 'sqls' then
          client.server_capabilities.documentFormattingProvider = false
        end

        local map = vim.keymap.set
        local bufopts = { noremap = true, silent = true, buffer = bufnr } -- Options for buffer-local mappings.

        -- LSP Navigation and Information
        map('n', 'gd', vim.lsp.buf.definition, bufopts) -- Go to definition.
        map('n', 'gr', vim.lsp.buf.references, bufopts) -- List references.
        map('n', 'K', vim.lsp.buf.hover, bufopts) -- Show hover information.

        -- Code Actions
        map('n', '<leader>rn', vim.lsp.buf.rename, bufopts) -- Rename symbol.
        map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts) -- Show code actions.

        -- Attach nvim-navic for breadcrumb navigation if the server supports document symbols.
        if client.server_capabilities.documentSymbolProvider then
          -- nvim-navic provides a breadcrumb display in the statusline or winbar.
          -- It requires 'MunifTanjim/nvim-navic' to be installed.
          if pcall(require, 'nvim-navic') then
             require('nvim-navic').attach(client, bufnr)
          end
        end
      end

      -- Setup Mason for managing LSP servers.
      require('mason').setup()
      -- Setup Mason-LSPconfig to bridge Mason with nvim-lspconfig.
      require('mason-lspconfig').setup {
        ensure_installed = { -- List of LSP servers to ensure are installed via Mason.
          'lua_ls',    -- Lua language server.
          'pyright',   -- Python type checker and language server.
          'ruff',      -- Python linter (can also act as an LSP via ruff-lsp).
          'yamlls',    -- YAML language server.
          'tsserver',  -- TypeScript language server (renamed to ts_ls in some contexts, but tsserver is common for mason).
          'bashls',    -- Bash language server.
          'sqls',      -- SQL language server.
        },
        automatic_installation = true, -- Automatically install servers listed in `ensure_installed`.
      }

      -- Handler function for mason-lspconfig to set up each server.
      require('mason-lspconfig').setup_handlers {
        -- Default handler: sets up server with capabilities and on_attach.
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,
        -- Custom setups for specific servers can be added here if needed, e.g.:
        -- ["pyright"] = function() require('lspconfig').pyright.setup { on_attach = on_attach, capabilities = capabilities, settings = { ... } } end,
      }

      -- Import server-specific configurations from separate files.
      -- These files can contain custom settings for individual LSP servers.
      require 'plugins.lsp.servers.lua'
      require 'plugins.lsp.servers.pyright'
      require 'plugins.lsp.servers.ruff'
      require 'plugins.lsp.servers.yamlls'
      -- Note: tsserver, bashls, sqls are using the default handler above.

      -- Autocommand group for LSP auto-formatting on save.
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      vim.api.nvim_create_autocmd('BufWritePre', { -- Before writing a buffer.
        group = augroup,
        pattern = '*', -- Apply to all file types.
        callback = function()
          -- Attempt to format the buffer using an LSP server that supports formatting.
          -- `async = false` makes it synchronous; consider `true` for very large files if performance is an issue.
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
  },
}
