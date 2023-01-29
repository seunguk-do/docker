local M = {}

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  require("config.lsp.keymaps").setup(client, bufnr)
  require("config.lsp.highlight").setup(client, bufnr)
end

local flags = {
    debounce_text_changes = 150,
}

local lua_setting = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = "LuaJIT",
      -- Setup your lua path
      path = vim.split(package.path, ";"),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
      },
    },
  },
}

function M.setup()

  require("lspconfig")['sumneko_lua'].setup{
    on_attach=on_attach,
    flags=flags,
    settings = lua_setting
  }
  require("lspconfig")['pyright'].setup{
    on_attach=on_attach,
    flags=flags,
    analysis = {
      typeCheckingMode = "off",
    },
  }
end

return M
