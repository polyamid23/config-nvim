local lspconfig = require 'lspconfig'

lspconfig.angularls.setup({
  on_attach = function()
    for _, server in ipairs(vim.lsp.buf_get_clients()) do
      if server.name == "tsserver" then
        local tsserver = vim.lsp.get_client_by_id(server.id)
        tsserver.server_capabilities.renameProvider = false
      end
    end
  end
})
