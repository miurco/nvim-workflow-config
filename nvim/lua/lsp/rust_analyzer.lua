vim.lsp.config.rust_analyzer = {
  cmd = { 'rust-analyzer' },
  root_markers = { 
    'Cargo.toml',
    'rust-project.json',
    '.git',
  },
  filetypes = { 'rust' },
  autostart = true,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = 'clippy',
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
