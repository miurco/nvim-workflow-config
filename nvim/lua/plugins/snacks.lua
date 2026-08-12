require('snacks').setup({
	explorer = {
		finder = {
			cmd = "find",
		},
	},
	picker = {
		enabled = true,
		sources = {
			explorer = {
				layout = {
					preset = "sidebar",
					preview = false,
					layout = {
						width = 100,
					},
				},
			},
		},
	},

	input = {
		enabled = true,
	},

	terminal = {
		enabled = true,
	}
})
