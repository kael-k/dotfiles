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
			"<leader>,",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume last action (grep, file, qflist etc...)",
		},
		{
			"<leader>k",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
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
			"<leader>ff",
			function()
				Snacks.picker.files({
					hidden = true,
					ignored = true,
					follow = true,
				})
			end,
			desc = "Find Files",
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
		-- Search with LSP or Vim-related stuff
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
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
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
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- Help / docs related
		{
			"<leader>hM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
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
		-- Vim related keys
		{
			"<leader>va",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>vc",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>vh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>vH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>vC",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
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
}
