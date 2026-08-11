local modes = { "n", "v", "i", "t" }

local splits = {
	{ "<A-Tab>", "<C-w>p", mode = modes, desc = "Go to previous window" },
}
local function ss()
	return require("smart-splits")
end
for key, dir in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	vim.list_extend(splits, {
		{
			"<A-" .. key .. ">",
			function()
				ss()["move_cursor_" .. dir]()
			end,
			mode = modes,
			desc = "Move focus " .. dir,
		},
		{
			"<A-C-" .. key .. ">",
			function()
				ss()["swap_buf_" .. dir]()
				ss()["move_cursor_" .. dir]()
			end,
			mode = modes,
			desc = "Swap window " .. dir,
		},
		{
			"<A-C-S-" .. key .. ">",
			function()
				ss()["resize_" .. dir](1)
			end,
			mode = modes,
			desc = "Resize " .. dir,
		},
	})
end

return {
	{ "windwp/nvim-autopairs", opts = {} },
	{ "tpope/vim-sleuth" },
	{ "mg979/vim-visual-multi" },
	{
		"mrjones2014/smart-splits.nvim",
		-- build = "./kitty/install-kittens.bash",
		event = "VeryLazy",
		keys = splits,
		opts = {},
	},
}
