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
			"<leader>wT",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Test Summary",
		},
		{
			"<leader>tR",
			function()
				require("neotest").run.run_last()
			end,
			desc = "Run last test(s)",
		},
		{
			"<leader>tD",
			function()
				require("neotest").run.run_last({ strategy = "dap" })
			end,
			desc = "Debug last test(s)",
		},
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test(s)",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug nearest test(s)",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.attach()
			end,
			desc = "Test: Attach",
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
