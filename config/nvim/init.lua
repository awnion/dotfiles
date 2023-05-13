require('plugins')
require('keymaps')

HOME = os.getenv("HOME")

vim.opt.swapfile = true
vim.opt.number = true
vim.opt.mouse = a
vim.opt.termguicolors = true

vim.opt.syntax = "on"
vim.opt.background = "dark"
vim.cmd("colorscheme one")

vim.opt.showtabline = 2
vim.opt.numberwidth = 5
vim.opt.colorcolumn = { 80, 120 }

vim.opt.clipboard = "unnamedplus"

-- TODO: should use .editorconfig
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- vim.opt.encoding = utf8

vim.opt.errorbells = false
vim.opt.visualbell = false

