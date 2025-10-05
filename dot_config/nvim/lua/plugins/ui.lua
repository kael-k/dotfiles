local function setqflist(picker, append)
	local sel = picker:selected()
	local items = #sel > 0 and sel or picker:items()
	local qf = {} ---@type vim.quickfix.entry[]
	for _, item in ipairs(items) do
		qf[#qf + 1] = {
			filename = Snacks.picker.util.path(item),
			bufnr = item.buf,
			lnum = item.pos and item.pos[1] or 1,
			col = item.pos and item.pos[2] + 1 or 1,
			end_lnum = item.end_pos and item.end_pos[1] or nil,
			end_col = item.end_pos and item.end_pos[2] + 1 or nil,
			text = item.line or item.comment or item.label or item.name or item.detail or item.text,
			pattern = item.search,
			valid = true,
		}
	end
	if append then
		vim.fn.setqflist(qf, "a")
	else
		vim.fn.setqflist(qf)
	end
end

return {
	{ "mg979/vim-visual-multi" },
	{
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
	},
	{
		"folke/which-key.nvim",
		config = true,
		event = "VeryLazy",
		opts = { delay = 250 },
	},
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"<leader>sr",
				function()
					require("spectre").open()
				end,
				desc = "Search & Replace (Spectre)",
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			---@type snacks.picker.Config
			picker = {
				enabled = true,
				ui_select = true,
				actions = {
					qflist = function(picker)
						setqflist(picker)
					end,
					qflist_append = function(picker)
						setqflist(picker, true)
					end,
				},
				sources = {
					explorer = {
						layout = {
							preview = { main = true, enabled = false },
						},
						win = {
							list = {
								keys = {
									["<C-t>"] = { "tab", mode = { "n", "i" } },
								},
							},
						},
					},
				},
				win = {
					input = {
						keys = {
							["<C-t>"] = { "tab", mode = { "n", "i" } },
							["<C-q>"] = { "qflist", mode = { "n", "i" } },
							["<CM-q>"] = { "qflist_append", mode = { "n", "i" } },
						},
					},
				},
			},

			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			rename = { enabled = true },
			bufdelete = { enabled = true },
			styles = {
				notification_history = {
					keys = {
						q = "close",
						n_esc = { "<esc>", { "close" }, mode = "n", expr = true },
					},
					wo = {
						wrap = true,
					},
				},
			},
		},

		keys = {

			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>:",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},

			{
				"<leader>wn",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>we",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			{
				"<leader>ws",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<leader>wq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List",
			},

			-- Find files and buffers
			{
				"<leader>fC",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>fG",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Recent",
			},
			-- git
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>gh",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},
			{
				"<leader>gW",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			-- Search
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				'<leader>s"',
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>s/",
				function()
					Snacks.picker.search_history()
				end,
				desc = "Search History",
			},
			{
				"<leader>sa",
				function()
					Snacks.picker.autocmds()
				end,
				desc = "Autocmds",
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>sC",
				function()
					Snacks.picker.commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>se",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>sE",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				function()
					Snacks.picker.highlights()
				end,
				desc = "Highlights",
			},
			{
				"<leader>sj",
				function()
					Snacks.picker.jumps()
				end,
				desc = "Jumps",
			},
			{
				"<leader>k",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sl",
				function()
					Snacks.picker.loclist()
				end,
				desc = "Location List",
			},
			{
				"<leader>sm",
				function()
					Snacks.picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sM",
				function()
					Snacks.picker.man()
				end,
				desc = "Man Pages",
			},
			{
				"<leader>sR",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume",
			},
			{
				"<leader>su",
				function()
					Snacks.picker.undo()
				end,
				desc = "Undo History",
			},
			{
				"<leader>ds",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>dS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
			-- Goto LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			-- Other
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>Ss",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
		},
		init = function()
			require("snacks")
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		-- build = "./kitty/install-kittens.bash",
		lazy = false,
		keys = {
			-- Focus movement - works in normal, visual, and terminal modes
			{
				"<A-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Move focus left",
			},
			{
				"<A-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Move focus down",
			},
			{
				"<A-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Move focus up",
			},
			{
				"<A-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Move focus right",
			},

			-- Window swapping
			{
				"<A-C-h>",
				function()
					smart_split = require("smart-splits")
					smart_split.swap_buf_left()
					smart_split.move_cursor_left()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Swap window left",
			},
			{
				"<A-C-j>",
				function()
					smart_split = require("smart-splits")
					smart_split.swap_buf_down()
					smart_split.move_cursor_down()
				end,  
				mode = { "n", "v", "x", "i", "t" },
				desc = "Swap window down",
			},  
			{  
				"<A-C-k>",  
				function()  
					smart_split = require("smart-splits")
					smart_split.swap_buf_up()
					smart_split.move_cursor_up()
				end,  
				mode = { "n", "v", "x", "i", "t" },
				desc = "Swap window up",
			},  
			{  
				"<A-C-l>",  
				function()  
					smart_split = require("smart-splits")
					smart_split.swap_buf_right()
					smart_split.move_cursor_right()
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Swap window right",
			},

			-- Resizing
			{
				"<A-C-S-h>",
				function()
					require("smart-splits").resize_left(1)
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Resize left",
			},
			{
				"<A-C-S-j>",
				function()
					require("smart-splits").resize_down(1)
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Resize down",
			},
			{
				"<A-C-S-k>",
				function()
					require("smart-splits").resize_up(1)
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Resize up",
			},
			{
				"<A-C-S-l>",
				function()
					require("smart-splits").resize_right(1)
				end,
				mode = { "n", "v", "x", "i", "t" },
				desc = "Resize right",
			},

			-- Alt+Tab for previous window (built-in)
			{ "<A-Tab>", "<C-w>p", mode = { "n", "v", "x", "i", "t" }, desc = "Go to previous window" },
		},
		opts = {},
	},
}
