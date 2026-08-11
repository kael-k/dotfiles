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
				html = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				less = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				lua = { "stylua" },
				markdown = { "markdownlint" },
				scss = { "prettier" },
				sh = { "shfmt" },
				python = { "ruff_format" },
				toml = function(bufnr)
					local name = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
					return name == "pyproject.toml" and { "pyproject-fmt" } or {}
				end,
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
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				desc = "Run formatter(s)",
			},
		},
	},
}
