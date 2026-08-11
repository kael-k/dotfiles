local filename = { "filename", file_status = true, newfile_status = true, path = 1 }
local right = { "encoding", "fileformat", "filetype" }

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { {
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			} },
			lualine_b = { "diagnostics" },
			lualine_c = { filename },
			lualine_x = right,
			lualine_y = {},
			lualine_z = { "%l:%c/%L" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = { "diagnostics" },
			lualine_c = { filename },
			lualine_x = right,
			lualine_y = {},
			lualine_z = { "%l:%c/%L" },
		},
		tabline = {
			lualine_a = { "branch", "diff" },
			lualine_b = {
				{
					"tabs",
					max_length = vim.o.columns * 0.8,
					mode = 2,
					path = 0,
					use_mode_colors = true,
				},
			},
		},
	},
}
