return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-neotest/neotest",
  },
  opts = function()
    return {
      winopts = {
        height = 0.85,
        width  = 0.80,
        row    = 0.30,
        col    = 0.50,
        border = "rounded",
      },
      files = {
        previewer = "builtin",
      },
      grep = {
        -- keep your original ripgrep opts
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case",
      },
    }
  end,
  keys = {
    -- your original z-prefixed pickers
    { "<leader>zf", function() require("fzf-lua").files() end,        desc = "Find Files" },
    { "<leader>zg", function() require("fzf-lua").live_grep() end,    desc = "Live Grep" },
    { "<leader>zb", function() require("fzf-lua").buffers() end,      desc = "Buffers" },
    { "<leader>zh", function() require("fzf-lua").help_tags() end,    desc = "Help Tags" },
    { "<leader>zc", function() require("fzf-lua").git_commits() end,  desc = "Git Commits" },

    -- test-centric helpers (works with neotest installed)
    {
      "<leader>zt",
      function()
        local fzf = require("fzf-lua")
        local globs = {
          -- python
          "-g", "test_*.py", "-g", "*_test.py", "-g", "tests/**.py",
          -- go
          "-g", "*_test.go",
          -- rust
          "-g", "tests/**.rs", "-g", "*_test.rs",
          -- C / C++
          "-g", "*_test.c", "-g", "*_test.cc", "-g", "*_test.cpp",
        }
        fzf.files({
          prompt = "Test files> ",
          fd_opts = table.concat(vim.list_extend({
            "--type", "f", "--hidden", "--follow",
            "--exclude", ".git", "--color", "never",
          }, globs), " "),
        })
      end,
      desc = "Tests: Pick test file",
    },
  },
}

