
-- Tmux-aware navigation: Ctrl+h/j/k/l to navigate between splits and tmux panes
-- If at edge of vim splits, pass through to tmux.
local function navigate(direction)
	local win_before = vim.fn.winnr()
	vim.cmd('wincmd ' .. direction)
	local win_after = vim.fn.winnr()

	-- If we didn't move (at edge), send command to tmux
	if win_before == win_after then
		local tmux_direction = ({
			h = 'L',
			j = 'D',
			k = 'U',
			l = 'R'
		})[direction]
		vim.fn.system('tmux select-pane -' .. tmux_direction)
	end
end
vim.keymap.set('n', '<C-h>', function() navigate('h') end, { desc = 'Navigate left', silent = true })
vim.keymap.set('n', '<C-j>', function() navigate('j') end, { desc = 'Navigate down', silent = true })
vim.keymap.set('n', '<C-k>', function() navigate('k') end, { desc = 'Navigate up', silent = true })
vim.keymap.set('n', '<C-l>', function() navigate('l') end, { desc = 'Navigate right', silent = true })

-- Resize mode: press <leader>H/J/K/L once, then use h/j/k/l to resize, Esc to exit
local resize_step = 4
local function enter_resize_mode()
	local resize_mappings = {
		h = '<Cmd>vertical resize -' .. resize_step .. '<CR>',
		j = '<Cmd>resize +' .. resize_step .. '<CR>',
		k = '<Cmd>resize -' .. resize_step .. '<CR>',
		l = '<Cmd>vertical resize +' .. resize_step .. '<CR>',
	}
	
	print('[RESIZE MODE] h/j/k/l to resize, <Esc> to exit')
	
	-- Set temporary keymaps for resize mode
	for key, cmd in pairs(resize_mappings) do
		vim.keymap.set('n', key, cmd, { silent = true, buffer = true })
	end
	
	-- Exit resize mode on Esc or any other key
	vim.keymap.set('n', '<Esc>', function()
		-- Remove temporary keymaps
		for key, _ in pairs(resize_mappings) do
			vim.keymap.del('n', key, { buffer = true })
		end
		vim.keymap.del('n', '<Esc>', { buffer = true })
		print('[RESIZE MODE] Exited')
	end, { silent = true, buffer = true })
end

vim.keymap.set('n', '<leader>H', function() enter_resize_mode() end, { desc = 'Enter resize mode', silent = true })
vim.keymap.set('n', '<leader>J', function() enter_resize_mode() end, { desc = 'Enter resize mode', silent = true })
vim.keymap.set('n', '<leader>K', function() enter_resize_mode() end, { desc = 'Enter resize mode', silent = true })
vim.keymap.set('n', '<leader>L', function() enter_resize_mode() end, { desc = 'Enter resize mode', silent = true })

-- Move split windows with <Tab>h/j/k/l
vim.keymap.set('n', '<Tab>h', '<C-w>H', { desc = 'Move window left', silent = true })
vim.keymap.set('n', '<Tab>j', '<C-w>J', { desc = 'Move window down', silent = true })
vim.keymap.set('n', '<Tab>k', '<C-w>K', { desc = 'Move window up', silent = true })
vim.keymap.set('n', '<Tab>l', '<C-w>L', { desc = 'Move window right', silent = true })

-- Buffer and quit operations
vim.keymap.set('n', '<leader>Q', '<Cmd>wqa!<CR>', { desc = 'Save all and quit', silent = true })
vim.keymap.set('n', '<leader>q', '<Cmd>w | bd<CR>', { desc = 'Save and close buffer', silent = true })


-- Quick list navigation
vim.keymap.set('n', ']q',
	function()
		if not pcall(vim.cmd, 'cnext') then vim.cmd('cfirst') end
		vim.cmd('normal! zvzz')
	end, { desc = 'Quickfix next (wrap)' })
vim.keymap.set('n', '>>', '<Cmd>cnext<CR>', { desc = 'Quickfix: next' })
vim.keymap.set('n', '<<', '<Cmd>cprevious<CR>', { desc = 'Quickfix: prev' })
vim.keymap.set('n', ']l', function()
	if not pcall(vim.cmd, 'lnext') then vim.cmd('lfirst') end
	vim.cmd('normal! zvzz')
end, { desc = 'Loclist: next (wrap)' })
vim.keymap.set('n', '[l', function()
	if not pcall(vim.cmd, 'lprevious') then vim.cmd('llast') end
	vim.cmd('normal! zvzz')
end, { desc = 'Loclist: prev (wrap)' })





-- One liner execution, TJ's source
vim.keymap.set("n", "<leader>x", function()
	local line = vim.api.nvim_get_current_line()
	vim.cmd("lua " .. line)
end, { desc = "Run current Lua line" })




-- LSP manual activation
vim.keymap.set('n', '<leader>ls', '<Cmd>LspStart<CR>', { desc = 'Start LSP' })

-- Explore directory
vim.keymap.set('n', '<leader>e', '<Cmd>lua Snacks.explorer.open()<CR>', { desc = 'Explore' })
