return {
  -- >> GIT (LazyGit) << --
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit" },
    keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" } }
  },

  -- >> GIT SIGNS (Gitsigns) << --
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { virt_text_pos = "eol", delay = 300 },
    },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame line (popup)" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
    },
  },

  -- >> Clojure nREPL (Conjure) << --
  {
    "Olical/conjure",
    ft = { "clojure", "clojurescript", "clojurec", "edn" },
    keys = {
      { "<leader>ce", "<cmd>ConjureEvalCurrentForm<cr>", desc = "Eval current form (nREPL)" },
      { "<leader>cE", "<cmd>ConjureEvalRootForm<cr>", desc = "Eval root form (nREPL)" },
      {
        "<leader>cS",
        function()
          local project_file = vim.fn.findfile("project.clj", ".;")
          local root = project_file ~= "" and vim.fn.fnamemodify(project_file, ":h") or vim.loop.cwd()

          vim.notify("Starting nREPL via lein...", vim.log.levels.INFO)
          local connected = false

          vim.fn.jobstart({ "lein", "repl", ":headless" }, {
            cwd = root,
            on_stdout = function(_, data)
              if connected or not data then return end
              for _, line in ipairs(data) do
                local host, port = line:match("nrepl://([%d%.]+):(%d+)")
                if host and port then
                  connected = true
                  vim.schedule(function()
                    vim.cmd("ConjureConnect " .. host .. ":" .. port)
                    vim.notify("Connected to nREPL on " .. host .. ":" .. port, vim.log.levels.INFO)
                  end)
                  return
                end
              end
            end,
            on_stderr = function(_, data)
              if not data then return end
              for _, line in ipairs(data) do
                if line ~= "" then
                  vim.schedule(function()
                    vim.notify(line, vim.log.levels.WARN)
                  end)
                  return
                end
              end
            end,
          })
        end,
        desc = "Start lein nREPL and connect",
      },
    },
  },

  -- >> TERMINAL (ToggleTerm) << --
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]], -- Open with Ctrl + \
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
    keys = {
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (Float)" },
    }
  },

  -- >> WHICH-KEY (Keymap hints) << --
  { 
    "folke/which-key.nvim", 
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>c", group = "+Code (LSP)", icon = " " },
        { "<leader>f", group = "+Find (Telescope)", icon = " " },
        { "<leader>g", group = "+Git", icon = " " },
        { "<leader>t", group = "+Terminal", icon = " " },
        { "<leader>e", desc = "Explorer", icon = " " },
      }
    } 
  },
}