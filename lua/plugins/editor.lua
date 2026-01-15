return {
  -- >> FILE EXPLORER (Neo-tree) << --
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = { { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File Explorer" } },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = { hide_dotfiles = false },
      }
    },
  },

  -- >> FUZZY FINDER (Telescope) << --
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      defaults = {
        preview = {
          treesitter = false, -- Disabled to prevent crashes on Windows/initial setup
        },
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    },
  },

  -- >> SYNTAX HIGHLIGHTING (Treesitter) << --
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function() 
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then return end

      configs.setup({
        ensure_installed = { 
            "c", "lua", "vim", "vimdoc", "query", 
            "python", "javascript", "typescript", "tsx", 
            "vue", "html", "css", "sql", "bash", "json", "markdown",
            "scala", "clojure", "c_sharp", "rust", "toml", "yaml", "dockerfile",
            "java", "kotlin", "groovy"
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
}