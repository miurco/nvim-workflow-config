vim.lsp.config.jdtls = {
  cmd = { 'jdtls' },
  root_markers = { 
    'pom.xml',
    'build.gradle',
    'build.gradle.kts',
    'settings.gradle',
    'settings.gradle.kts',
    '.git',
  },
  filetypes = { 'java' },
  autostart = false,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.mockito.Mockito.*',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        useBlocks = true,
      },
    },
  },
}
