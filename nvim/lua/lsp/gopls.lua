vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  root_markers = {
    'go.work',
    'go.mod',
    '.git',
  },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  autostart = true,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        ignoredError = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
