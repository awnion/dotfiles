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

-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})


-- format on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "lua vim.lsp.buf.format()" })

local black_on_save = vim.api.nvim_create_augroup("black_on_save", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*.py", command = "silent! Black", group = black_on_save })

-- disable editorconfig in gitcommit
vim.api.nvim_create_autocmd("FileType", { pattern = "gitcommit", command = "let b:EditorConfig_disable = 1" })

-- indent foldmethod for some formats
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function ()
    vim.opt_local.foldmethod = "indent"
  end
})

-- line endings
vim.opt.listchars = { eol = '↵' }
vim.opt.list = true
