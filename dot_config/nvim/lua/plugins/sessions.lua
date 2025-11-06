return {
	"rmagatti/auto-session",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	lazy = false,
	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		enabled = true, -- Enables/disables auto creating, saving and restoring
		auto_save = true, -- Enables/disables auto saving session on exit
		auto_restore = true, -- Enables/disables auto restoring session on start
		auto_create = false, -- Enables/disables auto creating new session files. Can be a function that returns true if a new session file should be allowed
		auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
		cwd_change_handling = false, -- Automatically save/restore sessions when changing directories
		single_session_mode = false, -- Enable single session mode to keep all work in one session r

		-- The following are already the default values, no need to provide them if these are already the settings you want.
		session_lens = {
			picker = "snacks", -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also manually choose one. Falls back to vim.ui.select
			mappings = {
				delete_session = { "i", "<C-x>" },
				alternate_session = { "i", "<C-s>" },
				copy_session = { "i", "<C-y>" },
			},

			picker_opts = {
				-- For Snacks, you can set layout options here, see:
				-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
				--
				preset = "dropdown",
				preview = false,
				layout = {
					width = 0.4,
					height = 0.4,
				},
			},
			load_on_setup = true,
		},

		save_extra_data = function(_)
			local ok, breakpoints = pcall(require, "dap.breakpoints")
			if not ok or not breakpoints then
				return
			end

			local bps = {}
			local breakpoints_by_buf = breakpoints.get()
			for buf, buf_bps in pairs(breakpoints_by_buf) do
				bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
			end
			if vim.tbl_isempty(bps) then
				return
			end
			local extra_data = {
				breakpoints = bps,
			}
			return vim.fn.json_encode(extra_data)
		end,

		restore_extra_data = function(_, extra_data)
			local json = vim.fn.json_decode(extra_data)

			if json.breakpoints then
				local ok, breakpoints = pcall(require, "dap.breakpoints")

				if not ok or not breakpoints then
					return
				end
				for buf_name, buf_bps in pairs(json.breakpoints) do
					for _, bp in pairs(buf_bps) do
						local line = bp.line
						local opts = {
							condition = bp.condition,
							log_message = bp.logMessage,
							hit_condition = bp.hitCondition,
						}
						breakpoints.set(opts, vim.fn.bufnr(buf_name), line)
					end
				end
			end
		end,
	},
	keys = {
		{ "<leader>vs/", "<cmd>AutoSession search<CR>", desc = "Session search" },
		{ "<leader>vss", "<cmd>AutoSession save<CR>", desc = "Save session" },
		{
			"<leader>vsS",
			function()
				local path = vim.fn.input({
					prompt = "Session name: ",
					default = vim.fn.getcwd(),
				})
				vim.cmd("AutoSession save " .. path)
			end,
			desc = "Save session with name",
		},
	},
}
