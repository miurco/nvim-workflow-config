-- Show LSP client information (mimics old :LspInfo)
vim.api.nvim_create_user_command('LspInfo', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  
  if #clients == 0 then
    print("No LSP clients attached to current buffer")
    print("\nConfigured servers: " .. table.concat(vim.tbl_keys(vim.lsp.config), ", "))
  else
    print("LSP clients attached to buffer " .. vim.api.nvim_get_current_buf() .. ":")
    print("")
    for _, client in ipairs(clients) do
      print("Client: " .. client.name .. " (id: " .. client.id .. ")")
      print("  Root dir: " .. (client.root_dir or "N/A"))
      print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))
      print("  Autostart: " .. tostring(client.config.autostart ~= false))
      print("")
    end
  end
  
  -- Show all active clients
  local all_clients = vim.lsp.get_clients()
  if #all_clients > #clients then
    print("Other active LSP clients:")
    for _, client in ipairs(all_clients) do
      local attached_to_current = false
      for _, c in ipairs(clients) do
        if c.id == client.id then
          attached_to_current = true
          break
        end
      end
      if not attached_to_current then
        print("  - " .. client.name .. " (id: " .. client.id .. ")")
      end
    end
  end
end, {})

-- Show ALL LSP clients in the entire Neovim process
vim.api.nvim_create_user_command('LspClients', function()
  local all_clients = vim.lsp.get_clients()
  
  if #all_clients == 0 then
    print("═══ No Active LSP Clients ═══")
    print("\nConfigured servers: " .. table.concat(vim.tbl_keys(vim.lsp.config), ", "))
    print("Tip: Use :LspStart to manually activate LSP for current buffer")
    return
  end
  
  print("═══ Active LSP Clients (" .. #all_clients .. ") ═══\n")
  
  for _, client in ipairs(all_clients) do
    print("┌─ " .. client.name .. " (id: " .. client.id .. ")")
    print("│  Root: " .. (client.root_dir or "N/A"))
    print("│  Cmd: " .. table.concat(client.config.cmd or {}, " "))
    print("│  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))
    
    -- Get attached buffers
    local attached_bufs = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        local buf_clients = vim.lsp.get_clients({ bufnr = buf, name = client.name })
        if #buf_clients > 0 then
          local bufname = vim.api.nvim_buf_get_name(buf)
          if bufname ~= "" then
            table.insert(attached_bufs, string.format("%d:%s", buf, vim.fn.fnamemodify(bufname, ":t")))
          end
        end
      end
    end
    
    if #attached_bufs > 0 then
      print("│  Attached buffers (" .. #attached_bufs .. "):")
      for _, bufinfo in ipairs(attached_bufs) do
        print("│    • " .. bufinfo)
      end
    else
      print("│  Attached buffers: none")
    end
    
    -- Show capabilities summary
    local caps = client.server_capabilities
    local cap_summary = {}
    if caps.completionProvider then table.insert(cap_summary, "completion") end
    if caps.hoverProvider then table.insert(cap_summary, "hover") end
    if caps.definitionProvider then table.insert(cap_summary, "definition") end
    if caps.referencesProvider then table.insert(cap_summary, "references") end
    if caps.renameProvider then table.insert(cap_summary, "rename") end
    if caps.documentFormattingProvider then table.insert(cap_summary, "formatting") end
    
    if #cap_summary > 0 then
      print("│  Capabilities: " .. table.concat(cap_summary, ", "))
    end
    
    print("└─")
    print("")
  end
  
  print("Tip: Use :LspInfo for current buffer or :LspStop to stop clients")
end, {})

-- Manually start LSP for current buffer
vim.api.nvim_create_user_command('LspStart', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  
  -- Map filetypes to LSP servers
  local ft_to_lsp = {
    zsh = 'bashls',
    sh = 'bashls',
    lua = 'lua_ls',
    c = 'clangd',
    cpp = 'clangd',
    rust = 'rust_analyzer',
    kotlin = 'kotlin_language_server',
    java = 'jdtls',
    javascript = 'ts_ls',
    javascriptreact = 'ts_ls',
    typescript = 'ts_ls',
    typescriptreact = 'ts_ls',
    go = 'gopls',
    gomod = 'gopls',
    gowork = 'gopls',
    gotmpl = 'gopls',
  }
  
  local server_name = ft_to_lsp[filetype]
  if not server_name then
    print("No LSP configured for filetype: " .. filetype)
    return
  end
  
  -- Check if already attached
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = server_name })
  if #clients > 0 then
    print("LSP already running: " .. server_name)
    return
  end
  
  -- Get the config and start the LSP
  local config = vim.lsp.config[server_name]
  if not config then
    print("LSP config not found: " .. server_name)
    return
  end
  
  -- Find root directory using the config's root_markers
  local root_dir = nil
  if config.root_markers then
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    root_dir = vim.fs.root(bufname, config.root_markers)
  end
  
  -- If no root found but single_file_support is enabled, use file's directory
  if not root_dir then
    if config.single_file_support then
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      root_dir = vim.fs.dirname(bufname)
      print("Using single file mode for: " .. server_name .. " (dir: " .. root_dir .. ")")
    else
      print("Could not find project root for: " .. server_name)
      print("Looking for: " .. table.concat(config.root_markers or {}, ", "))
      return
    end
  end
  
  -- Create a new config with the root_dir set
  local start_config = vim.tbl_extend('force', config, {
    root_dir = root_dir,
  })
  
  vim.lsp.start(start_config, { bufnr = bufnr })
  print("Started LSP: " .. server_name .. " (root: " .. root_dir .. ")")
end, {})

-- Stop LSP clients attached to current buffer
vim.api.nvim_create_user_command('LspStop', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached to current buffer")
  else
    for _, client in ipairs(clients) do
      vim.lsp.stop_client(client.id)
      print("Stopped: " .. client.name)
    end
  end
end, {})

-- Restart LSP clients for current buffer
vim.api.nvim_create_user_command('LspRestart', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients to restart")
  else
    for _, client in ipairs(clients) do
      local client_name = client.name
      vim.lsp.stop_client(client.id)
      vim.cmd('edit') -- Reload buffer to trigger autostart
      print("Restarted: " .. client_name)
    end
  end
end, {})

-- Command to show highlight group under cursor
vim.api.nvim_create_user_command('HighlightUnderCursor', function()
	local bufnr = vim.api.nvim_get_current_buf()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	row = row - 1 -- 0-indexed
	
	print('=== Highlight Info ===')
	print('')
	
	-- Get treesitter captures
	local ts_captures = vim.treesitter.get_captures_at_cursor(0)
	if #ts_captures > 0 then
		print('📦 Treesitter captures:')
		for _, capture in ipairs(ts_captures) do
			local hl_group = '@' .. capture
			local hl_info = vim.api.nvim_get_hl(0, { name = hl_group })
			
			-- Check if highlight is defined
			if next(hl_info) ~= nil then
				print('  ' .. hl_group)
				if hl_info.fg then
					print('    fg: #' .. string.format('%06x', hl_info.fg))
				end
				if hl_info.bg then
					print('    bg: #' .. string.format('%06x', hl_info.bg))
				end
				if hl_info.bold then print('    bold: true') end
				if hl_info.italic then print('    italic: true') end
				if hl_info.underline then print('    underline: true') end
				if hl_info.link then
					print('    links to: ' .. hl_info.link)
				end
			else
				print('  ' .. hl_group .. ' ❌ NOT DEFINED')
			end
		end
	else
		print('📦 Treesitter: no captures')
	end
	
	print('')
	
	-- Get syntax highlight group (fallback when treesitter is off)
	local syn_group = vim.fn.synIDattr(vim.fn.synID(row + 1, col + 1, 1), 'name')
	if syn_group ~= '' then
		print('🎨 Syntax highlight group: ' .. syn_group)
		local syn_info = vim.api.nvim_get_hl(0, { name = syn_group })
		if next(syn_info) ~= nil then
			if syn_info.fg then
				print('    fg: #' .. string.format('%06x', syn_info.fg))
			end
			if syn_info.bg then
				print('    bg: #' .. string.format('%06x', syn_info.bg))
			end
			if syn_info.link then
				print('    links to: ' .. syn_info.link)
			end
		else
			print('    ❌ NOT DEFINED')
		end
	else
		print('🎨 Syntax: none')
	end
	
	print('')
	print('Tip: Add missing highlights in nvim/lua/config/highlights.lua')
end, {})

-- Keymap for easy access
vim.keymap.set('n', '<leader>hi', '<Cmd>HighlightUnderCursor<CR>', { desc = 'Show highlight info' })
