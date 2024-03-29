vim.keymap.set("n", "<leader>w", ":w<cr>")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- window resize
vim.keymap.set('n', '<A-j>', '<C-w>+')
vim.keymap.set('n', '<A-k>', '<C-w>-')
vim.keymap.set('n', '<A-h>', '<C-w><')
vim.keymap.set('n', '<A-l>', '<C-w>>')

-- window movement
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)
vim.keymap.set('n', '<leader>ee', vim.cmd.Vex)
vim.keymap.set('n', '<leader>es', vim.cmd.Sex)

-- quickfix
vim.keymap.set('n', '<F7>', vim.cmd.cprev)
vim.keymap.set('n', '<F8>', vim.cmd.cnext)
