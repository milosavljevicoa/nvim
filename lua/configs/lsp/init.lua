
  local lsp_config_ok, lspconfig = pcall(require, "lspconfig")
  if not lsp_config_ok then
    error("lspconfig failed to load")
    return
  end
  local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
  if not lsp_installer_ok then
    error("nvim-lsp-installer failed to load")
    return
  end
  lsp_installer.setup {}
  local tbl_deep_extend = vim.tbl_deep_extend
  local handlers = require "configs.lsp.handlers"
  handlers.setup()

  -- use this witout lsp-installer but need to manulay install these
  -- local servers = { 'pyright', 'angularls', 'html', 'tsserver', 'sumneko_lua' }
  local servers = {}
  for _, server in ipairs(lsp_installer.get_installed_servers()) do
    table.insert(servers, server.name)
  end

  for _, server in ipairs(servers) do
    local opts = {
      on_attach = function(client, bufnr)
        handlers.on_attach(client, bufnr)
      end,
      capabilities = tbl_deep_extend("force", handlers.capabilities, lspconfig[server].capabilities or {}),
    }
    local present, av_overrides = pcall(require, "configs.lsp.server-settings." .. server)
    if present then
      opts = tbl_deep_extend("force", av_overrides, opts)
    end
    lspconfig[server].setup(opts)
  end

