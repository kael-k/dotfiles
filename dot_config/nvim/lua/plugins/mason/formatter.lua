local packages = { "clang-format", "markdownlint", "prettier", "pyproject-fmt", "ruff", "shfmt", "stylua" }

return {
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
			toml = { "pyproject-fmt" },
			yaml = { "prettier" },
		},
		formatters = {
			stylua = {
				prepend_args = { "--indent-type", "Tabs", "--indent-width", "1" }, -- width used only for *alignment*
			},
			["pyproject-fmt"] = {
				condition = function(_, ctx)
					return vim.fs.basename(ctx.filename) == "pyproject.toml"
				end,
			},
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		local registry = require("mason-registry")
		for _, name in ipairs(packages) do
			local ok, pkg = pcall(registry.get_package, name)
			if ok and not pkg:is_installed() then
				pkg:install()
			end
		end
	end,
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			desc = "Run formatter(s)",
		},
	},
}
