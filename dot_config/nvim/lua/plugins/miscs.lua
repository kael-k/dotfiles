return {
	{ "windwp/nvim-autopairs", config = true },
	{ "numToStr/Comment.nvim", config = true },
	{ "tpope/vim-sleuth" },
	{ "mg979/vim-visual-multi" },
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
		config = function()
			require("hardtime").setup()
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		-- build = "./kitty/install-kittens.bash",
		event = "VeryLazy",
		keys = {
			-- Focus movement - works in normal, visual, and terminal modes
			{
				"<A-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Move focus left",
			},
			{
				"<A-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Move focus down",
			},
			{
				"<A-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Move focus up",
			},
			{
				"<A-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Move focus right",
			},

			-- Window swapping
			{
				"<A-C-h>",
				function()
					smart_split = require("smart-splits")
					smart_split.swap_buf_left()
					smart_split.move_cursor_left()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Swap window left",
			},
			{
				"<A-C-j>",
				function()
					smart_split = require("smart-splits")
					smart_split.swap_buf_down()
					smart_split.move_cursor_down()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Swap window down",
			},
			{
				"<A-C-k>",
				function()
					smart_split = require("smart-splits")
					smart_split.swap_buf_up()
					smart_split.move_cursor_up()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Swap window up",
			},
			{
				"<A-C-l>",
				function()
					smart_split = require("smart-splits")
					smart_split.swap_buf_right()
					smart_split.move_cursor_right()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Swap window right",
			},

			-- Resizing
			{
				"<A-C-S-h>",
				function()
					require("smart-splits").resize_left(1)
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Resize left",
			},
			{
				"<A-C-S-j>",
				function()
					require("smart-splits").resize_down(1)
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Resize down",
			},
			{
				"<A-C-S-k>",
				function()
					require("smart-splits").resize_up(1)
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Resize up",
			},
			{
				"<A-C-S-l>",
				function()
					require("smart-splits").resize_right(1)
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Resize right",
			},

			-- Alt+Tab for previous window (built-in)
			{ "<A-Tab>", "<C-w>p", mode = { "n", "v", "x", "i", "t" }, desc = "Go to previous window" },
		},
		opts = {},
	},
}
