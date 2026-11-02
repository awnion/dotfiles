vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end, { buffer = bufnr })
      -- Code actions
      vim.keymap.set("n", "<Leader>a", function()
        vim.cmd.RustLsp("codeAction")
      end, { buffer = bufnr })
    end,
    default_settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}
