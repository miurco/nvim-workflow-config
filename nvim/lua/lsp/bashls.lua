vim.lsp.config.bashls = {
  cmd = { 'bash-language-server', 'start' },
  root_markers = { '.git' },
  filetypes = { 'sh', 'bash' },
  autostart = false,
  single_file_support = true,
  settings = {
    bashIde = {
      -- Glob pattern for finding and parsing shell script files in the workspace
      globPattern = '*@(.sh|.inc|.bash|.command)',
    },
  },
}
