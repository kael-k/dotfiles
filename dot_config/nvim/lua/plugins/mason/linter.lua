local linters_by_ft = {
	c = { "codespell" },
	h = { "codespell" },
	markdown = { "markdownlint" },
	sh = { "shellcheck" },
	yaml = { "yamllint" },
}

local packages = { "codespell", "markdownlint", "shellcheck", "yamllint", "mypy" }

return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"mason-org/mason.nvim",
	},
	config = function()
		require("lint").linters_by_ft = linters_by_ft

		local registry = require("mason-registry")
		for _, name in ipairs(packages) do
			local ok, pkg = pcall(registry.get_package, name)
			if ok and not pkg:is_installed() then
				pkg:install()
			end
		end

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
		{
			"<leader>lm",
			function()
				require("lint").try_lint("mypy")
			end,
			desc = "Run mypy (slow, on demand)",
		},
	},
}
