return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						-- { find = "; after #%d+" },
						-- { find = "; before #%d+" },
						-- { kind = "wmsg" },
						{ find = "^%d+ fewer lines;?" },
						{ find = "^%d+ more lines;?" },
						{ find = "^%d+ line lesses;?" },
						{ find = "^%d+ lines .ed %d+ times?$" },
						{ find = "^%d+ lines yanked$" },
					},
				},
				opts = { skip = true },
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
