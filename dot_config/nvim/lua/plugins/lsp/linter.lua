return {
	{
		"rshkarin/mason-nvim-lint",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-lint",
		},
		opts = {
			ensure_installed = {
				"codespell",
				"shellcheck",
				"ruff",
				"markdownlint",
				"mypy",
				"yamllint",
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				c = { "codespell" }, -- spell issues in identifiers/comments
				h = { "codespell" },
				json = { "yamllint" },
				markdown = { "markdownlint" },
				python = { "ruff", "mypy" },
				sh = { "shellcheck" },
				yaml = { "yamllint" },
			}

			-- run linters on save
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
		keys = {
			{
				"<leader>ll",
				function()
					require("lint").try_lint()
				end,
				desc = "Run linter(s)",
			},
		},
	},
}
