vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server', '--stdio'},
  root_markers = { '.git', '.luarc.json', '.luarc.jsonc' },
  filetypes = { 'lua' },
  autostart = false,
  settings = {
    Lua = {
      -- Make the server aware of Neovim runtime files
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      -- Tell lua_ls about Neovim's Lua API
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Add additional libraries if needed
          -- "${3rd}/luv/library",
          -- "${3rd}/busted/library",
        },
      },
      -- Disable telemetry
      telemetry = { enable = false },
      -- Configure diagnostics
      diagnostics = {
        -- Recognize vim global
        globals = { 'vim' },
	severity = {min = 'Error'},
	enable = false
      },
      -- Improve completion
      completion = {
        callSnippet = 'Replace',
      },
      -- Configure lua_ls to provide inlay hints
      hint = { enable=true },
    },
  },
}
