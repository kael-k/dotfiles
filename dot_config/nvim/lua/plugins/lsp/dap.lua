return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			ensure_installed = {
				"codelldb",
				"cpptools",
				"debugpy",
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
		"mfussenegger/nvim-dap",
		dependencies = {
			"mason-org/mason.nvim",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup dap-ui
			dapui.setup()

			-- Auto open/close dap-ui on start/end of debugging session
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

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
	{
		"Jorenar/nvim-dap-disasm",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = true,
	},
}
