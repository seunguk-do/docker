local M = {}

function M.setup()
  require("lspconfig").sumneko_lua.setup {}
  require("lspconfig").pyright.setup {}
end

return M
