require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://json.schemastore.org/kustomization.json'] = 'kustomization.yaml',
        ['https://json.schemastore.org/kubernetes.json'] = '/*.k8s.yaml',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yaml',
      },
      format = {
        enable = true,
      },
    },
  },
}
