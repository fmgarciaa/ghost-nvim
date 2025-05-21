return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      { 'williamboman/mason.nvim', version = '1.11.0' },
      { 'williamboman/mason-lspconfig.nvim', version = '1.32.0' },
    },
    config = function()
      -- Setup LSP capabilities with cmp_nvim_lsp support
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Diagnostic filtering for Pyright
      local function filter_diagnostics(diagnostic)
        if diagnostic.source == 'Pyright' then
          return not (
            diagnostic.message:match 'is not accessed'
            or diagnostic.message:match 'could not be resolved'
            or diagnostic.message:match 'Expression value is unused'
          )
        end
        return true
      end

      -- Override global diagnostics handler
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(function(_, params, ...)
        params.diagnostics = vim.tbl_filter(filter_diagnostics, params.diagnostics)
        vim.lsp.diagnostic.on_publish_diagnostics(_, params, ...)
      end, {})

      -- Diagnostics configuration
      vim.diagnostic.config {
        virtual_text = {
          prefix = '~',
          spacing = 4,
          source = 'if_many',
          format = function(diagnostic)
            return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source or 'unknown', diagnostic.code or '')
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '', -- Error icon
            [vim.diagnostic.severity.WARN] = '', -- Warning icon
            [vim.diagnostic.severity.INFO] = '', -- Info icon
            [vim.diagnostic.severity.HINT] = '', -- Hint icon
          },
        },
        underline = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
          format = function(diagnostic)
            return string.format('%s\n\n%s: %s', diagnostic.message, diagnostic.source or 'unknown', diagnostic.code or '')
          end,
          header = { ' Diagnostics:', 'DiagnosticHeader' },
          prefix = function(diagnostic)
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

      -- Set custom highlight colors for diagnostics
      local diagnostic_colors = {
        DiagnosticError = '#F44747',
        DiagnosticWarn = '#FFCC00',
        DiagnosticInfo = '#75BEFF',
        DiagnosticHint = '#4EC9B0',
      }

      for group, color in pairs(diagnostic_colors) do
        vim.api.nvim_set_hl(0, group, { fg = color })
      end

      -- Set underline for diagnostic severity levels
      local diagnostic_underline = {
        DiagnosticUnderlineError = { undercurl = true, sp = '#F44747' },
        DiagnosticUnderlineWarn = { undercurl = true, sp = '#FFCC00' },
        DiagnosticUnderlineInfo = { undercurl = true, sp = '#75BEFF' },
        DiagnosticUnderlineHint = { undercurl = true, sp = '#4EC9B0' },
      }

      for group, attrs in pairs(diagnostic_underline) do
        vim.api.nvim_set_hl(0, group, attrs)
      end

      -- LSP key mappings for common actions
      local function on_attach(client, bufnr)
        -- disable formatting capability for sqls so null-ls can handle it
        if client.name == 'sqls' then
          client.server_capabilities.documentFormattingProvider = false
        end

        local map = vim.keymap.set
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        -- LSP Navigation
        map('n', 'gd', vim.lsp.buf.definition, bufopts)
        map('n', 'gr', vim.lsp.buf.references, bufopts)
        map('n', 'K', vim.lsp.buf.hover, bufopts)
        -- Code actions
        map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end
      end

      -- Mason and Mason-LSPconfig setup
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'pyright', 'ruff', 'yamlls', 'ts_ls', 'bashls', 'sqls' },
        automatic_installation = true,
      }

      -- Server setup handler
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,
      }

      -- Import server-specific configurations
      require 'plugins.lsp.servers.lua'
      require 'plugins.lsp.servers.pyright'
      require 'plugins.lsp.servers.ruff'
      require 'plugins.lsp.servers.yamlls'

      -- Auto-formatting for any file on save
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        pattern = '*', -- Applies to all file types
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
  },
}
