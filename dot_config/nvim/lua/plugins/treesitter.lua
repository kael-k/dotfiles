return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").install({
				"bash",
				"c",
				"css",
				"devicetree",
				"html",
				"javascript",
				"json",
				"jsdoc",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					if not vim.treesitter.language.get_lang(ev.match) then
						return
					end
					if pcall(vim.treesitter.start, ev.buf) then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
