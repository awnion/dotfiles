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

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- see https://github.com/folke/lazy.nvim#-plugin-spec
require("lazy").setup({
  { "nvim-telescope/telescope.nvim",    tag = "0.1.1",         dependencies = { "nvim-lua/plenary.nvim" }, },
  { 'nvim-treesitter/nvim-treesitter',  build = ":TSUpdate" },
  { 'tpope/vim-surround' },

  { 'itchyny/lightline.vim' },
  { 'airblade/vim-gitgutter' },

  -- :MasonUpdate updates registry contents
  { "williamboman/mason.nvim",          build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },

  -- LSP
  { 'neovim/nvim-lspconfig' },
  { 'simrat39/rust-tools.nvim' },
  { 'psf/black' },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',         opts = {} },

  -- -- Theme inspired by Atom
  -- {
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',        opts = {} },

  -- justfile
  { 'NoahTheDuke/vim-just' },
  { 'IndianBoy42/tree-sitter-just' },

  -- editorconfig
  { 'editorconfig/editorconfig-vim' },
})
