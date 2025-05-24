-- This file configures nvimtools/none-ls.nvim (formerly null-ls), a tool for integrating
-- formatters and linters into Neovim's LSP client. None-ls makes these tools
-- behave like LSP servers, providing diagnostics and formatting capabilities.

-- Return the plugin specification for lazy.nvim.
return {
  'nvimtools/none-ls.nvim', -- The plugin's repository name.
  dependencies = { -- List of dependencies for none-ls.
    'nvimtools/none-ls-extras.nvim', -- Provides extra built-in sources for none-ls.
    { 'williamboman/mason.nvim', version = '1.11.0' }, -- Mason for managing external tools.
    'jay-babu/mason-null-ls.nvim', -- Integrates Mason with none-ls (null-ls was its old name, plugin name might persist).
                                   -- This helps install formatters/linters via Mason.
    'gbprod/none-ls-shellcheck.nvim', -- Specific integration for shellcheck if not covered by extras.
  },
  config = function() -- Function to run after the plugin and its dependencies are loaded.
    -- Setup Mason to ensure it's available for mason-null-ls.
    require('mason').setup()

    -- Setup mason-null-ls to manage the installation of formatters and linters.
    require('mason-null-ls').setup {
      ensure_installed = { -- List of tools to ensure are installed via Mason.
        'stylua', -- Lua formatter.
        'isort', -- Python import sorter/formatter.
        'sqruff', -- SQL linter and formatter (a rust port of sqlfluff).
        'sqlfluff', -- Python based SQL linter and formatter (alternative or complement to sqruff).
        'prettier', -- Multi-language formatter (JSON, YAML, Markdown, HTML, JS, TS, etc.).
        'yamllint', -- YAML linter.
        'shfmt', -- Shell script formatter.
        'shellcheck', -- Shell script linter.
      },
      automatic_installation = true, -- Automatically install tools listed in `ensure_installed`.
    }

    -- Load the main none-ls module.
    local null_ls = require 'null-ls'
    -- Get references to none-ls's built-in sources for formatting and diagnostics.
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Define the path to a custom sqlfluff configuration file.
    -- This allows using project-specific or user-specific sqlfluff rules.
    local sqlfluff_config_path = vim.fn.expand '~/.sqlfluff' -- Expands '~' to the home directory.

    -- Define the list of sources (formatters and linters) for none-ls.
    local sources = {
      formatting.stylua, -- Use stylua for Lua formatting.
      formatting.isort, -- Use isort for Python import sorting.

      -- Configure sqruff for diagnostics (linting).
      -- `with { extra_args = ... }` allows passing additional command-line arguments.
      diagnostics.sqruff.with { extra_args = { '--config', sqlfluff_config_path } },
      -- Configure sqruff for formatting.
      formatting.sqruff.with { extra_args = { '--config', sqlfluff_config_path } },
      -- Note: Using both sqlfluff and sqruff might be redundant if sqruff is a full replacement.
      -- If sqlfluff (python version) is preferred for some tasks, it would be configured similarly.

      -- Configure prettier for formatting multiple filetypes.
      formatting.prettier.with {
        filetypes = { -- Explicitly list filetypes prettier should handle.
          'json', 'yaml', 'yml', 'markdown', 'html', 'javascript', 'typescript', 'dockerfile',
        },
        -- Prettier can also be configured with `extra_args` for config paths or other options.
      },
      diagnostics.yamllint, -- Use yamllint for YAML diagnostics.
      formatting.shfmt, -- Use shfmt for shell script formatting.
      require('none-ls-shellcheck.diagnostics'), -- Use the shellcheck diagnostics source from the dedicated plugin.
    }

    -- Create an autocommand group for none-ls auto-formatting.
    -- This prevents interference with other autocommands.
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {}) -- Re-using 'LspFormatting' or could be 'NullLsFormatting'.

    -- Setup none-ls with the defined sources and an on_attach function.
    null_ls.setup {
      sources = sources,
      on_attach = function(client, bufnr) -- Function to run when none-ls attaches to a buffer.
        -- Check if the none-ls client attached to this buffer supports formatting.
        if client.supports_method 'textDocument/formatting' then
          -- Clear any existing BufWritePre autocommands in this group for this buffer.
          -- This is important to avoid duplicate formatting commands if on_attach runs multiple times.
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          -- Create an autocommand to format the buffer before saving.
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- Use Neovim's LSP formatting function. Since none-ls acts like an LSP server,
              -- this will trigger the appropriate none-ls formatter for the filetype.
              vim.lsp.buf.format { async = false } -- `async = false` for synchronous formatting.
                                                 -- Consider `timeout_ms` if formatters are slow.
            end,
          })
        end
      end,
      -- Other none-ls options:
      -- debug = false, -- Enable debug logging for none-ls.
      -- update_in_insert = false, -- Whether to update diagnostics in insert mode.
    }
  end,
}
