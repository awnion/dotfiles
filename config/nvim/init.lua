HOME = os.getenv("HOME")

vim.opt.swapfile = true
vim.opt.number = true
vim.opt.mouse = a
vim.opt.termguicolors = true

vim.opt.syntax = "on"
vim.opt.background = "dark"

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

vim.opt.updatetime = 100

require('plugins')
require('keymaps')

---
--- Misc
---
vim.cmd.colorscheme 'one'

-- format on save
vim.cmd [[ autocmd BufWritePre * lua vim.lsp.buf.format() ]]

-- disable editorconfig in gitcommit
vim.cmd [[ autocmd FileType gitcommit let b:EditorConfig_disable = 1 ]]
