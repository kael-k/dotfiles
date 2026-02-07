return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"bashls",
				"clangd",
				"copilot",
				"dockerls",
				"docker_compose_language_service",
				"html",
				"jsonls",
				"marksman",
				"pyright",
				"ruff",
				"rust_analyzer",
				"tailwindcss",
				"yamlls",
			},
		},
		config = function(_, opts)
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup(opts)

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			servers = mason_lspconfig.get_installed_servers()
			for _, server in ipairs(servers) do
				vim.lsp.config(server, { capabilities = capabilities })
			end
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
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			cmp = require("cmp")
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
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
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
