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
        "<leader>cs",
        function()
          local nrepl_file = vim.fn.findfile(".nrepl", ".;")
          if nrepl_file == "" then
            vim.notify(".nrepl not found in project root", vim.log.levels.WARN)
            return
          end

          local lines = vim.fn.readfile(nrepl_file)
          local port = lines[1] and lines[1]:match("%d+")
          if not port then
            vim.notify("Invalid .nrepl port", vim.log.levels.ERROR)
            return
          end

          vim.cmd("ConjureConnect localhost:" .. port)
        end,
        desc = "Connect nREPL from .nrepl",
      },
      {
        "<leader>cS",
        function()
          local project_file = vim.fn.findfile("project.clj", ".;")
          local root = project_file ~= "" and vim.fn.fnamemodify(project_file, ":h") or vim.loop.cwd()

          vim.notify("Starting nREPL via lein...", vim.log.levels.INFO)
          vim.fn.jobstart({ "lein", "repl", ":headless" }, { cwd = root, detach = true })

          local timer = vim.loop.new_timer()
          local function try_connect()
            local nrepl_file = vim.fn.findfile(".nrepl", root .. ";")
            if nrepl_file ~= "" then
              timer:stop()
              timer:close()
              local lines = vim.fn.readfile(nrepl_file)
              local port = lines[1] and lines[1]:match("%d+")
              if not port then
                vim.notify("Invalid .nrepl port", vim.log.levels.ERROR)
                return
              end
              vim.cmd("ConjureConnect localhost:" .. port)
              vim.notify("Connected to nREPL on port " .. port, vim.log.levels.INFO)
            end
          end

          timer:start(200, 200, vim.schedule_wrap(try_connect))
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