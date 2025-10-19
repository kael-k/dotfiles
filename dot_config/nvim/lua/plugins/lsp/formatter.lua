return {
	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"stevearc/conform.nvim",
		},
		opts = {
			ensure_installed = {
				"clang-format",
				"shfmt",
				"ruff",
				"stylua",
				"markdownlint",
				"pyproject-fmt",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
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
		},
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Run formatter(s)",
			},
		},
	},
}
