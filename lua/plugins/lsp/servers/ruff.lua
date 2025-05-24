-- This file configures Ruff, an extremely fast Python linter and formatter,
-- written in Rust. It can be used as an LSP server (ruff-lsp) for diagnostics
-- and formatting. Configuration is done via nvim-lspconfig.

-- Get the lspconfig module.
local lspconfig = require('lspconfig')

-- Setup for ruff-lsp.
lspconfig.ruff.setup {
  -- `cmd` specifies the command to start the ruff LSP server.
  -- This might be necessary if `ruff server` is the correct invocation instead of just `ruff-lsp`.
  cmd = { 'ruff', 'server' },

  -- `filetypes` specifies which filetypes this LSP server should attach to.
  filetypes = { 'python' },

  -- `init_options` are passed to the server during initialization.
  -- These are specific to ruff-lsp.
  init_options = {
    settings = {
      -- `configurationPreference = 'editorOnly'` might indicate that ruff should
      -- prioritize settings passed directly from the editor over project files (e.g., pyproject.toml),
      -- or it could relate to how configurations are discovered. (Behavior might need checking in ruff-lsp docs).
      configurationPreference = 'editorOnly',

      -- `exclude` specifies a list of directories or glob patterns to exclude from linting and formatting.
      exclude = { '**/tests/**', '.venv', 'venv', 'env', '__pycache__', 'migrations', '.pytest_cache', '.git' },

      -- `lineLength` sets the target line length for formatting.
      lineLength = 125,

      -- `organizeImports = false` disables ruff's import organization feature.
      -- This might be set to `false` if another tool (like isort via none-ls) handles import sorting.
      -- If `true`, ruff would also sort/organize imports.
      organizeImports = false,

      -- `showSyntaxErrors = true` enables display of syntax errors found by ruff's parser.
      showSyntaxErrors = true,

      -- `logFile` specifies a path for ruff-lsp's log file. Useful for debugging.
      logFile = '~/ruff.log', -- Expands to home directory.
      -- `logLevel` sets the verbosity of the logs ("debug", "info", "warn", "error").
      logLevel = 'debug',

      -- `configuration` section mirrors the structure often found in pyproject.toml for ruff.
      -- This allows defining ruff's linting and formatting rules directly in the LSP setup.
      configuration = {
        lint = {
          -- `select` enables specific lint rule codes or prefixes.
          -- E: pycodestyle errors, F: pyflakes, B: flake8-bugbear, Q: flake8-quotes,
          -- I: isort (if organizeImports were true), PL: Pylint, D: pydocstyle,
          -- AIR: ?? (custom or less common), ARG: flake8-unused-arguments,
          -- ERA: eradicate, FAST: ??, DJ: flake8-django, ANN: flake8-annotations.
          select = { 'E', 'F', 'B', 'Q', 'I', 'PL', 'D', 'AIR', 'PL', 'ARG', 'ERA', 'FAST', 'DJ', 'ANN' },
          -- `ignore` disables specific lint rule codes.
          -- D102: Missing docstring in public method, D107: Missing docstring in __init__, D100: Missing docstring in public module.
          ignore = { 'D102', 'D107', 'D100' },
        },
        format = {
          -- `quote-style` specifies the preferred quote style for strings ("double" or "single").
          ['quote-style'] = 'double',
          -- `docstring-code-format = true` enables formatting of code examples within docstrings.
          ['docstring-code-format'] = true,
        },
      },
    },
  },
  -- The `on_attach` function and `capabilities` are typically inherited from the
  -- global LSP setup in `lua/plugins/lsp/lsp.lua`. If server-specific `on_attach`
  -- behavior or capabilities were needed, they would be defined here.
}
