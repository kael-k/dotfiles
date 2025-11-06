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
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = true,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mason-org/mason.nvim",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup dap-ui
			dapui.setup()

			dap.adapters = {
				python = {},
				gdb = {
					id = "gdb",
					type = "executable",
					command = "gdb",
					args = { "--quiet", "--interpreter=dap" }, -- starts gdb as a DAP server
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
					args = {}, -- optional: arguments to program
				},
				{
					name = "Attach to process (GDB)",
					type = "gdb",
					request = "attach",
					processId = require("dap.utils").pick_process, -- pick a pid interactively
				},
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Debug this file (python)",
					program = "${file}",
					pythonPath = function()
						return vim.fn.exepath('python')
					end
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
						return vim.fn.exepath('python')
					end
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
						return vim.fn.exepath('python')
					end
				},
			}

			-- Key mappings for debugging
			local map = vim.keymap.set
			map("n", "<leader>dc", dap.continue, { desc = "Continue/Start Debugging" })
			map("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
			map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			map("n", "<leader>do", dap.step_out, { desc = "Step Out" })
			map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			map("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Set Conditional Breakpoint" })
			map("n", "<leader>wd", dap.repl.open, { desc = "Open REPL" })
			map("n", "<leader>wD", dapui.toggle, { desc = "Toggle DAP UI" })
		end,
	},
}
