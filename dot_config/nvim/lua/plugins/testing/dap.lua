return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			ensure_installed = {
				"python",
				"go-debug-adapter",
			},
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		},
	},
	{
		"igorlfs/nvim-dap-view",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {},
		keys = {
			{
				"<leader>wd",
				":DapViewToggle<CR>",
				desc = "Toggle DAP",
			},
		},
	},
	{
		"Jorenar/nvim-dap-disasm",
		dependencies = {
			"igorlfs/nvim-dap-view",
		},
		opts = {
			dapview_register = true,
		},
		dapview = {
			keymap = "D",
			label = "Disassembly [D]",
			short_label = "󰒓 [D]",
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mason-org/mason.nvim",
			"nvim-neotest/nvim-nio",
			"m00qek/baleia.nvim",
		},
		config = function()
			local dap = require("dap")

			dap.adapters = {
				python = {},
				gdb = {
					id = "gdb",
					type = "executable",
					command = "gdb",
					args = { "--quiet", "--interpreter=dap" },
				},
			}

			dap.configurations.c = {
				{
					name = "Run executable (GDB)",
					type = "gdb",
					request = "launch",
					program = function()
						local path = vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.getcwd() .. "/",
							completion = "file",
						})
						return (path ~= nil and path ~= "") and path or dap.ABORT
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					console = "externalTerminal", -- This is key: tells DAP to use external terminal
					externalTerminal = { -- Alternative configuration
						command = "tmux",
						args = { "split-window", "-h", "-p", "50" },
					},
					args = {}, -- optional: arguments to program
				},
			}
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Debug this file (python)",
					program = "${file}",
					pythonPath = function()
						return vim.fn.exepath("python")
					end,
				},
				{
					type = "python",
					request = "launch",
					name = "Debug a module (python)",
					module = function()
						return vim.fn.input({
							prompt = "Module name: ",
						})
					end,
					pythonPath = function()
						return vim.fn.exepath("python")
					end,
				},
				{
					type = "python",
					request = "launch",
					name = "Debug a module with custom args (python)",
					module = function()
						return vim.fn.input({
							prompt = "Module name: ",
						})
					end,
					args = function()
						return vim.fn.input({
							prompt = "Args: ",
						})
					end,
					pythonPath = function()
						return vim.fn.exepath("python")
					end,
				},
			}
			-- Setup ANSI colors for DAP
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "dap-repl",
				callback = function()
					vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
				end,
			})
		end,
		keys = {
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue/Start Debugging",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run again last debugging session",
			},
			{
				"<leader>dk",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate current session",
			},
			{
				"<leader>dn",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Set Conditional Breakpoint",
			},
		},
	},
}
