require("vim-options")
require("keymaps")
require("cmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" }, -- loads all plugins in plugins/
  },
  defaults = {
    lazy = false, -- plugins are not lazy loaded by default
  },
})

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false
})

vim.opt.expandtab=true
vim.opt.autoindent=true
vim.opt.shiftwidth=2
vim.opt.tabstop=2
vim.keymap.set('n', '<leader>o', ':silent update | !firefox "%"<CR>', { desc = "Open HTML in Firefox" })

vim.opt.linebreak=true
