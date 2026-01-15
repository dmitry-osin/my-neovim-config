-- ========================================================================== --
--  GENERAL KEYMAPS
-- ========================================================================== --
local map = vim.keymap.set

-- Clear search highlight on Esc
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = "Clear search highlight" })

-- Save file with Ctrl+S
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = "Save file" })

-- Exit insert mode quickly
map('i', 'jj', '<Esc>', { desc = "Exit insert mode" })
map('i', 'jk', '<Esc>', { desc = "Exit insert mode" })

-- Window Navigation (Ctrl + h/j/k/l)
map('n', '<C-h>', '<C-w>h', { desc = "Go to left window" })
map('n', '<C-j>', '<C-w>j', { desc = "Go to lower window" })
map('n', '<C-k>', '<C-w>k', { desc = "Go to upper window" })
map('n', '<C-l>', '<C-w>l', { desc = "Go to right window" })
map('n', '<C-Left>', '<C-w>h', { desc = "Go to left window" })
map('n', '<C-Down>', '<C-w>j', { desc = "Go to lower window" })
map('n', '<C-Up>', '<C-w>k', { desc = "Go to upper window" })
map('n', '<C-Right>', '<C-w>l', { desc = "Go to right window" })

-- Buffer Navigation (Tab / Shift+Tab)
map('n', '<Tab>', '<cmd>bnext<cr>', { desc = "Next buffer" })
map('n', '<S-Tab>', '<cmd>bprevious<cr>', { desc = "Previous buffer" })

-- Close current buffer
map('n', '<leader>q', '<cmd>bd<cr>', { desc = "Close buffer" })

-- Quickfix: close with q
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    vim.keymap.set("n", "q", "<cmd>cclose<cr>", { buffer = ev.buf, silent = true, desc = "Close quickfix" })
  end,
})