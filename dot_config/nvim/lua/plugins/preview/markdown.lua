return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	opts = {
		completions = { lsp = { enabled = true } },
		render_modes = { 'n', 'c', 't' },
		enabled = true
	},
	event = "VeryLazy",
	keys = {
		{
			"<leader>pm",
			"<cmd>RenderMarkdown toggle<CR>",
			desc = "Toggle markdown preview",
		},
	},
}
