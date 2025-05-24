-- This file configures Pyright, a static type checker and language server for Python,
-- developed by Microsoft. It's configured here using nvim-lspconfig.

-- Get the lspconfig module.
local lspconfig = require('lspconfig')

-- Setup for Pyright.
lspconfig.pyright.setup {
  -- `settings` allows passing configuration directly to Pyright.
  settings = {
    python = { -- Settings under the "python" namespace are for Pyright.
      analysis = {
        -- `typeCheckingMode` controls the strictness of type checking.
        -- "basic": Basic type checking rules.
        -- "strict": Stricter rules, often recommended for new projects.
        -- "off": Disables type checking (Pyright still provides other LSP features).
        typeCheckingMode = 'basic',

        -- `autoSearchPaths = true` allows Pyright to automatically discover import paths
        -- (e.g., from virtual environments or `src` directories).
        autoSearchPaths = true,

        -- `diagnosticMode` controls which files are analyzed for diagnostics.
        -- "openFilesOnly": Analyzes only files that are currently open in Neovim.
        -- "workspace": Analyzes all Python files in the workspace.
        diagnosticMode = 'openFilesOnly',

        -- `useLibraryCodeForTypes = true` enables Pyright to infer types from library code
        -- (e.g., .pyi files or inline type hints in installed packages).
        useLibraryCodeForTypes = true,

        -- Performance optimization settings.
        memory = true, -- Enables memory caching to speed up analysis on subsequent runs.
                       -- The exact meaning of `true` might be server-specific, often implies default caching.
        logLevel = 'Information', -- Sets the logging level for Pyright ("Information", "Warning", "Error").
                                  -- Useful for debugging server issues.

        -- Additional language features.
        autoImportCompletions = true, -- If true, Pyright will provide auto-import completions for known symbols.

        -- `exclude` specifies a list of directories or glob patterns to exclude from analysis.
        -- This is important for performance and relevance of diagnostics.
        exclude = {
          '**/node_modules/**', -- Common for projects with frontend components.
          '**/__pycache__/**', -- Python bytecode cache.
          '**/.venv/**', -- Common virtual environment directory name.
          '**/venv/**', -- Another common virtual environment directory name.
        },
        -- Other `analysis` options could include:
        -- "stubPath": Path to custom type stubs.
        -- "reportMissingImports": false, -- To suppress warnings for unresolved imports.
        -- "reportUndefinedVariable": "warning", -- Set severity for undefined variables.
      },
    },
  },
  -- `flags` can control LSP client behavior for this specific server.
  flags = {
    -- `debounce_text_changes` sets a delay (in milliseconds) before sending document
    -- changes to the server. This can prevent excessive updates while typing.
    debounce_text_changes = 150,
  },
  -- The `on_attach` function and `capabilities` are typically inherited from the
  -- global LSP setup in `lua/plugins/lsp/lsp.lua`. If server-specific `on_attach`
  -- behavior or capabilities were needed, they would be defined here.
}
