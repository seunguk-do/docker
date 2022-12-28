local M = {}

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  require("config.lsp.keymaps").setup(client, bufnr)
end

local flags = {
    debounce_text_changes = 150,
}

function M.setup()
  require("lspconfig")['sumneko_lua'].setup{
    on_attach=on_attach,
    flags=flags
  }
  require("lspconfig")['pyright'].setup{
    on_attach=on_attach,
    flags=flags
  }
end

return M
