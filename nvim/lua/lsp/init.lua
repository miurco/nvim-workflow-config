-- Load individual LSP server configurations with autostart disabled
-- NOTE: We only define the configs here, but don't call vim.lsp.enable()
-- This ensures LSPs won't start automatically. Use :LspStart to activate manually.
require('lsp.clangd')
require('lsp.rust_analyzer')
require('lsp.lua_ls')
require('lsp.kotlin_language_server')
require('lsp.jdtls')
require('lsp.ts_ls')
require('lsp.gopls')
require('lsp.bashls')

-- Set LSP float window borders
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.border_style })
-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = vim.g.border_style })

-- Disable LSP semantic token highlighting (use only treesitter)
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

-- Enable detailed LSP logging for troubleshooting
vim.lsp.log.set_level 'TRACE'

-- Open LSP log with: :LspLog
vim.api.nvim_create_user_command('LspLog', function()
	vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
end, { desc = 'Open LSP log file' })

-- Show LSP log path
vim.api.nvim_create_user_command('LspLogPath', function()
	print('LSP log file: ' .. vim.lsp.log.get_filename())
	print('Current log level: TRACE')
end, { desc = 'Show LSP log file path' })


-- These GLOBAL keymaps are created unconditionally when Nvim starts:
-- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
-- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
-- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
-- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
-- - "grt" is mapped in Normal mode to |vim.lsp.buf.type_definition()|
-- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
-- - CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
-- - "an" and "in" are mapped in Visual mode to outer and inner incremental
--   selections, respectively, using |vim.lsp.buf.selection_range()|
--
-- BUFFER-LOCAL DEFAULTS
-- - 'omnifunc' is set to |vim.lsp.omnifunc()|, use |i_CTRL-X_CTRL-O| to trigger
--   completion.
-- - 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like
--   go-to-definition, |:tjump|, and keymaps like |CTRL-]|, |CTRL-W_]|,
--   |CTRL-W_}| to utilize the language server.
-- - 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via
--   |gq| if the language server supports it.
--   - To opt out of this use |gw| instead of gq, or clear 'formatexpr' on |LspAttach|.
-- - |K| is mapped to |vim.lsp.buf.hover()| unless 'keywordprg' is customized or
--   a custom keymap for `K` exists.
-- - Document colors are enabled for highlighting color references in a document.
--   - To opt out call `vim.lsp.document_color.enable(false, args.buf)` on |LspAttach|.
--
--
