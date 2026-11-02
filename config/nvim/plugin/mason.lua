require("mason").setup()

local registry = require("mason-registry")

local packages = {
  "bash-language-server",
  "docker-language-server",
  "emmylua_ls",
  "gopls",
  "ruff",
  "rust-analyzer",
  "shellcheck",
  "tsc",
  "ty",
}

-- Install anything missing in the background; servers attach to buffers opened afterwards.
registry.refresh(vim.schedule_wrap(function()
  for _, name in ipairs(packages) do
    local package = registry.get_package(name)
    if not package:is_installed() and not package:is_installing() then
      package:once("install:failed", vim.schedule_wrap(function()
        if vim.v.exiting == vim.NIL then
          vim.notify("mason: failed to install " .. name .. ", see :Mason", vim.log.levels.WARN)
        end
      end))
      package:install()
    end
  end
end))
