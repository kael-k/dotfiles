return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup dap-ui
    dapui.setup()

    -- Auto open/close dap-ui on start/end of debugging session
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- Setup mason-nvim-dap with adapters to install
    require("mason-nvim-dap").setup({
      ensure_installed = {
        "debugpy",   -- Python debugger
        "codelldb",  -- Rust/C++ debugger
        "cpptools",
      },
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    })

    -- Key mappings for debugging
    local map = vim.keymap.set
    map("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
    map("n", "<F10>", dap.step_over, { desc = "Step Over" })
    map("n", "<F11>", dap.step_into, { desc = "Step Into" })
    map("n", "<F12>", dap.step_out, { desc = "Step Out" })
    map("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    map("n", "<leader>db", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Set Conditional Breakpoint" })
    map("n", "<leader>wd", dap.repl.open, { desc = "Open REPL" })
    map("n", "<leader>wD", dapui.toggle, { desc = "Toggle DAP UI" })
  end,
}

