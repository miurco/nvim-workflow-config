require('blink.cmp').setup({
	sources = {
		-- The lsp, path, snippets, luasnip, buffer, and omni sources are built-in
		-- default = { 'lsp', 'buffer', 'path', 'omni' }
		default = { 'omni', 'path', 'buffer', 'lsp' }
	},
	completion = {
		menu = {
			border = vim.g.border_style,
			draw = {
				columns = { { 'label', 'label_description', 'source_name', gap = 1 } },
				-- Custom component to show file paths
				components = {
					label_description = {
						width = { max = 50 },
						text = function(ctx)
							-- Show labelDetails.description if available
							if ctx.item.labelDetails and ctx.item.labelDetails.description then
								return ctx.item.labelDetails.description
							end
							-- Fallback: extract directory from full path
							if ctx.item.textEdit and ctx.item.textEdit.newText then
								local path = ctx.item.textEdit.newText:gsub('\\\\', '')
								local dir = path:match('(.*/)[^/]+$')
								if dir and dir ~= '' and ctx.label ~= path then
									return dir
								end
							end
							return ''
						end,
						highlight = 'BlinkCmpLabelDescription'
					}
				}
			}
		},
		documentation = {
			window = {
				border = vim.g.border_style
			}
		}
	},
	cmdline = {
		keymap = { preset = 'cmdline' },
		enabled = true
	}
})

-- List of available components: source_id, source_name, kind, label_description, label, kind_icon, got table: 0x01011af4d8
