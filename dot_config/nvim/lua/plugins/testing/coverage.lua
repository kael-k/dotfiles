return {
	"andythigpen/nvim-coverage",
	event = "VeryLazy",
	opts = {
		auto_reload = true,
	},
	keys = {
		{
			"<leader>tc",
			function()
				require("coverage").load(true)
			end,
			desc = "Coverage: load and show",
		},
		{
			"<leader>tC",
			function()
				require("coverage").summary()
			end,
			desc = "Coverage: summary",
		},
		{
			"<leader>tx",
			function()
				require("coverage").toggle()
			end,
			desc = "Coverage: toggle signs",
		},
	},
}
