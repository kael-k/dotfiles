return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"devicetree",
				"json",
				"lua",
				"make",
				"markdown",
				"python",
				"rust",
				"toml",
				"vim",
				"vimdoc",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
	},
}
