vim.lsp.config.clangd = {
  cmd = { 
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
  },
  root_markers = { 
    'compile_commands.json', 
    'compile_flags.txt',
    '.clangd',
    '.git',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  autostart = false,
}
