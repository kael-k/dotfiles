return {
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "tpope/vim-fugitive" },
	{
		"sindrets/diffview.nvim",
		keys = {
			{
				"<leader>gdo",
				function()
					vim.cmd("DiffviewOpen HEAD")
				end,
				desc = "Open git Diffview",
			},
			{
				"<leader>gdq",
				function()
					vim.cmd("DiffviewClose")
				end,
				desc = "Close git Diffview",
			},
		},
	},
}
