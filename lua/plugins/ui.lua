return {
  -- >> THEME (Catppuccin) << --
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },

  -- >> ICONS << --
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- >> COLOR HIGHLIGHTING (Colorizer) << --
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = { "*" },
  },

  -- >> STATUS LINE (Lualine) << --
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin",
        globalstatus = true,
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {
          statusline = { "neo-tree" },
        },
      },
      tabline = {
        lualine_a = { 'buffers' },
      },
      sections = {
        lualine_x = {
            {
                function()
                    local msg = 'No Active Lsp'
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    if next(clients) == nil then return msg end
                    return clients[1].name
                end,
                icon = ' LSP:',
                color = { fg = '#ffffff', gui = 'bold' },
            },
            'encoding', 'fileformat', 'filetype'
        },
      }
    },
  },

  -- >> DASHBOARD << --
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          week_header = { enable = true },
          shortcut = {
            { desc = '󰈞 Update Plugins', group = '@property', action = 'Lazy update', key = 'u' },
            { desc = ' Find Files', group = 'Label', action = 'Telescope find_files', key = 'f' },
            { desc = ' Find Text', group = 'DiagnosticHint', action = 'Telescope live_grep', key = 'g' },
            { desc = ' Recent Files', group = 'Number', action = 'Telescope oldfiles', key = 'r' },
            { desc = ' Configuration', group = 'Number', action = 'edit $MYVIMRC', key = 'c' },
            { desc = ' LazyGit', group = 'Number', action = 'LazyGit', key = 'l' },
          },
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },

  -- >> UI ENHANCEMENTS (Noice) << --
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = true, silent = true },
        signature = { enabled = true, auto_open = { enabled = true, trigger = true, luasnip = true, throttle = 50 } },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
  },
}