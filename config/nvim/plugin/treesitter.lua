local ts = require("nvim-treesitter")

vim.g.treesitter_parsers = {
  "bash",
  "go",
  "html",
  "javascript",
  "json",
  "json5",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

-- Quitting mid-install leaves temp dirs and CLI locks behind that make later installs fail.
local function clear_stale_install(lang)
  local cache = vim.fn.stdpath("cache")
  local leftovers = vim.fn.glob(cache .. "/tree-sitter-" .. lang .. "-tmp", false, true)
  local locks = vim.fs.dirname(cache) .. "/tree-sitter/lock/" .. lang .. "-*.lock"
  vim.list_extend(leftovers, vim.fn.glob(locks, false, true))
  for _, path in ipairs(leftovers) do
    vim.fn.delete(path, "rf")
  end
end

local installed = ts.get_installed("parsers")
local missing = vim.tbl_filter(function(lang)
  return not vim.list_contains(installed, lang)
end, vim.g.treesitter_parsers)
if #missing > 0 then
  clear_stale_install("*")
  ts.install(missing, { force = true })
end

local max_filesize = 100 * 1024 -- 100 KB
local installing = {}

local function start(buf, lang)
  local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
  if stats and stats.size > max_filesize then
    return
  end
  pcall(vim.treesitter.start, buf, lang)
end

-- Highlight every buffer with a parser, installing a missing parser on first use.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTreesitter", {}),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end

    if vim.list_contains(ts.get_installed("parsers"), lang) then
      start(args.buf, lang)
    elseif not installing[lang] and vim.list_contains(ts.get_available(), lang) then
      installing[lang] = true
      clear_stale_install(lang)
      ts.install(lang, { force = true }):await(function()
        installing[lang] = nil
        if vim.api.nvim_buf_is_valid(args.buf) then
          start(args.buf, lang)
        end
      end)
    end
  end,
})
