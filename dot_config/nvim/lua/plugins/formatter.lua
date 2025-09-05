return {
	{ "windwp/nvim-autopairs", config = true },
	{ "numToStr/Comment.nvim", config = true },
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
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
	{ "tpope/vim-sleuth" },
	{
		"stevearc/conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"zapling/mason-conform.nvim",
		},
		config = function()
			require("conform").setup({
				notify_on_error = true,
				formatters_by_ft = {
					c = { "clang_format" },
					h = { "clang_format" },
					sh = { "shfmt" },
					python = { "ruff_format", "pyproject-fmt" },
					lua = { "stylua" },
					markdown = { "markdownlint" }, -- formatter part of markdownlint-cli2
				},
				formatters = {
					stylua = {
						prepend_args = { "--indent-type", "Tabs", "--indent-width", "1" }, -- width used only for *alignment*
					},
				},
			})

			require("mason-conform").setup({
				ensure_installed = { "clang-format", "shfmt", "ruff", "stylua", "markdownlint", "pyproject-fmt" },
				automatic_installation = true,
			})

			-- keymap: format
			vim.keymap.set({ "n", "v" }, "<leader>lf", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format file/range" })
		end,
	},
}
