-- ========================================================================== --
--  GENERAL KEYMAPS
-- ========================================================================== --
local map = vim.keymap.set

-- Clear search highlight on Esc
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = "Clear search highlight" })

-- Save file with Ctrl+S
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = "Save file" })

-- Window Navigation (Ctrl + h/j/k/l)
map('n', '<C-h>', '<C-w>h', { desc = "Go to left window" })
map('n', '<C-j>', '<C-w>j', { desc = "Go to lower window" })
map('n', '<C-k>', '<C-w>k', { desc = "Go to upper window" })
map('n', '<C-l>', '<C-w>l', { desc = "Go to right window" })