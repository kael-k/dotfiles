return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
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
			vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp_document_symbol" },
					{ name = "buffer" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
			})
		end,
		keys = {
			{
				"<leader>hd",
				function()
					vim.lsp.buf.hover()
				end,
				desc = "Show symbol documentation",
			},
		},
	},
}
