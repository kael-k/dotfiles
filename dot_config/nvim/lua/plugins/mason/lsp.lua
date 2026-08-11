return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		opts = {
			ensure_installed = {
				"bashls",
				"clangd",
				"cssls",
				"dockerls",
				"docker_compose_language_service",
				"eslint",
				"html",
				"jsonls",
				"marksman",
				"pyright",
				"ruff",
				"rust_analyzer",
				"tailwindcss",
				"ts_ls",
				"yamlls",
			},
		},
		config = function(_, opts)
			vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter",
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			sources = {
				default = { "lsp", "path", "buffer" },
			},
			signature = { enabled = true },
		},
	},
}
