-- lua/plugins/testing.lua
return {
	"nvim-neotest/neotest",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim", -- REQUIRED
		"nvim-neotest/nvim-nio", -- REQUIRED
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
		"orjangj/neotest-ctest",
	},
	keys = {
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Test: Nearest",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Test: File",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "Test: Last",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Test: Summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Test: Output (float)",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.attach()
			end,
			desc = "Test: Attach",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Test: Debug Nearest (DAP)",
		},
		{
			"<leader>tL",
			function()
				local nt = require("neotest")
				nt.run.run_last()
				vim.defer_fn(function()
					nt.output.open({ enter = true, auto_close = true })
				end, 150)
			end,
			desc = "Tests: Run Last + Output",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Tests: Output (float)",
		},
	},
	config = function()
		require("neotest").setup({
			discovery = { enabled = true },
			running = { concurrent = true },
			output = { open_on_run = false },
			quickfix = { enabled = false },
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					args = { "-q" },
					runner = "pytest",
				}),
				require("neotest-go")({
					experimental = { test_table = true },
					args = { "-count=1", "-timeout=60s" },
				}),
				require("neotest-rust")({
					args = { "--no-capture" }, -- uses cargo-nextest
				}),
				-- require("neotest-ctest")({
				--  ctest_command = "ctest",
				-- }),
			},
		})
	end,
}
