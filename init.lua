-- ========================================================================== --
--  NEOVIM CONFIGURATION (Modular)
--  Stack: Lua, Python, JS/TS, Vue, HTML, CSS, SQL, Scala, Rust, C#, Clojure
-- ========================================================================== --

-- 1. Load Options & Keymaps
require("config.options")
require("config.keymaps")

-- 2. Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Setup Plugins
-- This will automatically import any file inside lua/plugins/*.lua
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = false },
  change_detection = { notify = false },
})