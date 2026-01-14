return {
  -- >> LSP CONFIGURATION & MASON << --
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        
        local handlers =  {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
          ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded" }),
        }

        mason_lspconfig.setup({ 
            ensure_installed = { "lua_ls", "ts_ls", "html", "cssls", "sqlls", "pyright" }, 
            automatic_installation = true,
            handlers = {
                function(server_name)
                    pcall(function()
                        lspconfig[server_name].setup({ capabilities = capabilities, handlers = handlers })
                    end)
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        handlers = handlers,
                        settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { library = vim.api.nvim_get_runtime_file("", true) } } },
                    })
                end,
                ["volar"] = function()
                    lspconfig.volar.setup({
                        capabilities = capabilities,
                        handlers = handlers,
                        filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
                    })
                end,
            }
        })

        -- LSP Keymaps
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            local function opts(desc)
                return { buffer = ev.buf, desc = desc }
            end
            
            -- Navigation
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts("Go to Definition"))
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts("Go to Declaration"))
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts("References"))
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts("Go to Implementation"))
            
            -- Info
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts("Documentation (Hover)"))
            vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts("Signature Help"))
            
            -- Actions
            vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts("Rename"))
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts("Code Action"))
            vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format { async = true } end, opts("Format Document"))
          end,
        })
    end,
  },

  -- >> AUTOCOMPLETION (CMP) << --
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets", "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item() elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump() else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
             if cmp.visible() then cmp.select_prev_item() elseif luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, { name = "nvim_lsp_signature_help" }, { name = "luasnip" },
        }, { { name = "buffer" }, { name = "path" } }),
      })
    end,
  },

  -- >> MINI CODING HELPERS << --
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },

  -- >> COMMENTS << --
  { 
    "numToStr/Comment.nvim", 
    keys = {
      { "gcc", mode = "n", desc = "Comment line" },
      { "gc", mode = { "n", "v" }, desc = "Comment block" },
      { "gb", mode = { "n", "v" }, desc = "Comment block" },
    },
    config = function()
      require("Comment").setup()
    end
  },
}