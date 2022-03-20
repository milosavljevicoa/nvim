local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

lsp_installer.on_server_ready(function(server)
  local opts = server:get_default_options()
  opts.on_attach = require("configs.lsp.handlers").on_attach
  opts.capabilities = require("configs.lsp.handlers").capabilities

  server:setup(opts)
end)
