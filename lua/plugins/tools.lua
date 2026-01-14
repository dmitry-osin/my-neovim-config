return {
  -- >> GIT (LazyGit) << --
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" } }
  },

  -- >> GIT SIGNS (Gitsigns) << --
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      current_line_blame_opts = { virt_text_pos = "eol", delay = 300 },
    },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame line (popup)" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
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