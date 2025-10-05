return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			preview_config = {
				border = "rounded",
			},
		},
		keys = {
			{
				"<leader>gB",
				function()
					require("gitsigns").blame()
				end,
				desc = "Git blame",
			},
			{
				"<leader>gdi",
				function()
					require("gitsigns").preview_hunk_inline()
				end,
				desc = "Git Preview hunk inline",
			},
			{
				"<leader>grh",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Git reset on current hunk",
			},
			{
				"<leader>grb",
				function()
					require("gitsigns").reset_buffer()
				end,
				desc = "Git reset on current buffer",
			},
		},
	},
	{
		"tpope/vim-fugitive",
		keys = {
			{
				"<leader>gdv",
				":Gvdiffsplit<CR>",
				desc = "Git vertical diff",
			},
			{
				"<leader>gdh",
				":Gdiffsplit<CR>",
				desc = "Git horrizontal diff",
			},
		},
	},
}
