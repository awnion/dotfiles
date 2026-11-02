-- Headless check of the Neovim config: run through tests/nvim-smoke.sh.
local ok, err = xpcall(function()
  -- Wait for the install the config started: quitting mid-install leaves stale state behind.
  local ts = require("nvim-treesitter")
  assert(vim.wait(300000, function()
    local installed = ts.get_installed("parsers")
    return vim.iter(vim.g.treesitter_parsers):all(function(lang)
      return vim.list_contains(installed, lang)
    end)
  end, 500), "treesitter parsers did not finish installing")

  -- A fenced code block exercises treesitter injections.
  local path = vim.fn.tempname() .. ".md"
  vim.fn.writefile({ "# Title", "", "```lua", "local x = 1", "```" }, path)
  vim.cmd.edit(path)
  local parser = vim.treesitter.get_parser(0)
  parser:parse(true)
  assert(parser:children().lua, "lua injection is missing from the markdown tree")
  assert(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()], "treesitter highlighting is not active")

  -- Saving a buffer that has no language server must stay silent.
  vim.cmd.write()
  assert(not vim.fn.execute("messages"):find("Format request failed", 1, true), "format on save warned about a missing server")
end, debug.traceback)

if not ok then
  io.stderr:write("nvim-smoke: " .. tostring(err) .. "\n")
  vim.cmd("cquit 1")
end

vim.cmd("qa!")
