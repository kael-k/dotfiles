return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
					refresh_time = 16, -- ~60fps
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"Filetype",
						"CursorMoved",
						"CursorMovedI",
						"ModeChanged",
					},
				},
			},
			sections = {
				lualine_a = { {
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				} },
				lualine_b = { "diagnostics" },
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = true,
						path = 1,
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = {},
				lualine_z = { "%l:%c/%L" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = { "diagnostics" },
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = true,
						component_separators = { left = "", right = "" },
						path = 1,
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
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
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
