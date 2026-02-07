return {
	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"stevearc/conform.nvim",
		},
		opts = {},
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
				css = { "prettier" },
				graphql = { "prettier" },
				h = { "clang_format" },
				json = { "prettier" },
				less = { "prettier" },
				lua = { "stylua" },
				markdown = { "markdownlint" },
				scss = { "prettier" },
				sh = { "shfmt" },
				python = { "ruff_format", "pyproject-fmt" },
				yaml = { "prettier" },
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
