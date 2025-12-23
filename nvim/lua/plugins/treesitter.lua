require('nvim-treesitter.configs').setup({
	-- Install parsers for these languages
	ensure_installed = {
		'lua', 'vim', 'vimdoc', 'query',  -- Neovim essentials
		'kotlin', 'java',                  -- Your main languages
		'c', 'cpp', 'rust',                -- Systems languages
		'javascript', 'typescript',        -- Web
		'python', 'bash',                  -- Scripting
		'json', 'yaml', 'toml',            -- Config files
		'markdown', 'markdown_inline',     -- Documentation
	},
	
	-- Install parsers synchronously (only on first install)
	sync_install = false,
	
	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	
	highlight = {
		enable = true,
		-- Disable for very large files (performance)
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		-- Use Vim regex highlighting in addition to Treesitter
		additional_vim_regex_highlighting = false,
	},
	
	-- Incremental selection (extend/shrink selection intelligently)
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<CR>',    -- Start selection
			node_incremental = '<CR>',  -- Expand to next node
			node_decremental = '<BS>',  -- Shrink selection
			scope_incremental = '<TAB>', -- Expand to scope
		},
	},
	
	-- Text objects (enable with treesitter-textobjects plugin if needed)
	textobjects = {
		select = {
			enable = false, -- Enable if you add treesitter-textobjects plugin
		},
	},
})
