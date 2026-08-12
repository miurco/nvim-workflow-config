vim.api.nvim_create_autocmd('LspAttach', {
	-- Default keymaps can be overriden here
	callback = function(event)
		-- print(string.format('event fired: %s', vim.inspect(event)))
		
		-- LSP keymaps
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local bufnr = event.buf
		local opts = { buffer = bufnr, silent = true }
			
			-- Navigation
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'LSP: Go to definition' }))
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'LSP: Go to declaration' }))
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'LSP: Find references' }))
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'LSP: Go to implementation' }))
			vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'LSP: Go to type definition' }))
			
			-- Documentation
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'LSP: Show hover documentation' }))
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'LSP: Signature help' }))
			vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'LSP: Signature help' }))
			
			-- Code actions and refactoring
			vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'LSP: Code action' }))
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'LSP: Rename' }))
			
			-- Formatting
			vim.keymap.set('n', '<leader>f', function()
				vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
			end, vim.tbl_extend('force', opts, { desc = 'LSP: Format document' }))
			vim.keymap.set('v', '<leader>f', function()
				vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
			end, vim.tbl_extend('force', opts, { desc = 'LSP: Format selection' }))
			
			-- Diagnostics
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'LSP: Previous diagnostic' }))
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'LSP: Next diagnostic' }))
			-- vim.keymap.set('n', '<Space>e', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'LSP: Show diagnostic' }))
			vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = 'LSP: Diagnostics to loclist' }))
			
			vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, vim.tbl_extend('force', opts, { desc = 'LSP: Workspace symbols' }))
			
			-- Inlay hints toggle
			if client:supports_method('textDocument/inlayHint') then
				vim.keymap.set('n', '<leader>th', function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
				end, vim.tbl_extend('force', opts, { desc = 'LSP: Toggle inlay hints' }))
			end
			
			-- Document highlight: highlight references to symbol under cursor
			if client:supports_method('textDocument/documentHighlight') then
				local highlight_augroup = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
				vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
					buffer = bufnr,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
					buffer = bufnr,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end
})


-- Help Doc Example what could be done in 'LspAttach'
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('my.lsp', {}),
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     if client:supports_method('textDocument/implementation') then
--       -- Create a keymap for vim.lsp.buf.implementation ...
--     end
--
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method('textDocument/completion') then
--       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--       -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--       -- client.server_capabilities.completionProvider.triggerCharacters = chars
--
--       vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
--     end
--
--     -- Auto-format ("lint") on save.
--     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--     if not client:supports_method('textDocument/willSaveWaitUntil')
--         and client:supports_method('textDocument/formatting') then
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
--         buffer = args.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
--         end,
--       })
--     end
--   end,
-- })
-- To see the capabilities for a given server, try this in a LSP-enabled buffer: >vim

    -- :lua =vim.lsp.get_clients()[1].server_capabilities
