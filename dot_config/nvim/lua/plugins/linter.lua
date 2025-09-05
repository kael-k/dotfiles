return {
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			"williamboman/mason.nvim",
			"rshkarin/mason-nvim-lint",
		},
		config = function()
			require("mason-nvim-lint").setup({
				ensure_installed = { "codespell", "shellcheck", "ruff", "markdownlint", "mypy" },
				automatic_installation = true,
			})

			local lint = require("lint")
			lint.linters_by_ft = {
				c = { "codespell" }, -- spell issues in identifiers/comments
				h = { "codespell" },
				sh = { "shellcheck" },
				python = { "ruff", "mypy" },
				markdown = { "markdownlint" },
			}

			-- run linters on save
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})

			-- keymap: lint now
			vim.keymap.set("n", "<leader>ll", function()
				require("lint").try_lint()
			end, { desc = "Run linters" })
		end,
	},
}
