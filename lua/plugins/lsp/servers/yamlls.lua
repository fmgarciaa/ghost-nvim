-- This file configures yamlls (YAML Language Server), which provides LSP features
-- for YAML files, such as validation, completion, hover, and formatting.
-- Configuration is done via nvim-lspconfig.

-- Get the lspconfig module.
local lspconfig = require('lspconfig')

-- Setup for yamlls.
lspconfig.yamlls.setup {
  -- `settings` allows passing configuration directly to the YAML Language Server.
  settings = {
    yaml = { -- Settings under the "yaml" namespace are for yamlls.
      -- `validate = true` enables validation of YAML files against their schemas
      -- or basic YAML syntax rules.
      validate = true,

      -- `hover = true` enables hover information (e.g., descriptions for schema properties).
      hover = true,

      -- `completion = true` enables completion suggestions (e.g., for keys based on schemas).
      completion = true,

      -- `schemas` defines a mapping between JSON Schema URIs and glob patterns for YAML files.
      -- This allows yamlls to validate YAML files against specific schemas.
      -- For example, GitHub workflow files are validated against the github-workflow.json schema.
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*', -- GitHub Actions workflows.
        ['https://json.schemastore.org/kustomization.json'] = 'kustomization.yaml', -- Kubernetes Kustomization files.
        ['https://json.schemastore.org/kubernetes.json'] = '/*.k8s.yaml', -- Kubernetes resource files (ending in .k8s.yaml).
                                                                           -- Note: A more general pattern like '*.+(k8s|kubernetes).yaml' might be useful.
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yaml', -- Docker Compose files.
        -- Additional custom schemas can be added here, e.g.:
        -- ['/path/to/my/custom/schema.json'] = '/my/project/specific/file.yaml',
      },

      -- `format` configures yamlls's built-in formatting capabilities.
      format = {
        enable = true, -- If true, enables formatting by yamlls.
                       -- This might be disabled if another tool like Prettier (via none-ls)
                       -- is preferred for YAML formatting.
        -- Other formatting options specific to yamlls could be set here, e.g.:
        -- singleQuote = false,
        -- printWidth = 80,
        -- proseline = false,
      },

      -- `maxItemsComputed` can limit the number of items (e.g., completions, diagnostics)
      -- the server computes to prevent performance issues on very large files or schemas.
      -- maxItemsComputed = 5000, (default value)

      -- `customTags` allows defining custom YAML tags for validation and completion.
      -- customTags = { "!Ref", "!GetAtt", ... },
    },
  },
  -- The `on_attach` function and `capabilities` are typically inherited from the
  -- global LSP setup in `lua/plugins/lsp/lsp.lua`. If server-specific `on_attach`
  -- behavior or capabilities were needed, they would be defined here.
}
