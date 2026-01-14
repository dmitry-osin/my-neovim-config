-- ========================================================================== --
--  VIM OPTIONS
-- ========================================================================== --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true          -- Show absolute line number
opt.relativenumber = true  -- Show relative line number
opt.mouse = "a"            -- Enable mouse support
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.breakindent = true     -- Maintain indent on wrapped lines
opt.undofile = true        -- Save undo history
opt.ignorecase = true      -- Case insensitive searching
opt.smartcase = true       -- ...unless capital letters are used
opt.signcolumn = "yes"     -- Always show sign column (for LSP/Git)
opt.updatetime = 250       -- Faster update time (better UI experience)
opt.timeoutlen = 300       -- Faster key sequence completion
opt.splitright = true      -- Split vertical windows to the right
opt.splitbelow = true      -- Split horizontal windows to the bottom
opt.termguicolors = true   -- Enable 24-bit RGB color
opt.cursorline = true      -- Highlight the current line
opt.scrolloff = 8          -- Keep 8 lines above/below cursor