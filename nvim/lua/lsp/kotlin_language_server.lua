vim.lsp.config.kotlin_language_server = {
  cmd = { 'kotlin-lsp', '--stdio' },
  root_markers = { 
    'settings.gradle.kts',
    'settings.gradle',
    'build.gradle.kts',
    'build.gradle',
    '.git',
  },
  filetypes = { 'kotlin' },
  autostart = false,
  settings = {},
}
