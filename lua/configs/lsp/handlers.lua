local M = {}

local nmap = require("core.utils").nmap

function M.setup()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config({
    virtual_text = true,
    -- signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    }
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local function lsp_keymaps()
  local opts = { noremap = true, silent = true }
  nmap('gd', vim.lsp.buf.definition, opts)
  nmap('gD', vim.lsp.buf.declaration, opts)
  nmap('gi', vim.lsp.buf.implementation, opts)
  nmap('GD', vim.lsp.buf.type_definition, opts)
  nmap('<space>fr', function()
    vim.lsp.buf.formatting({ async = true })
  end, opts)
end

M.on_attach = function(client)
  if client.name == "tsserver" or client.name == "jsonls" or client.name == "html" or client.name == "sumneko_lua" then
    client.server_capabilities.document_formatting = false
  end

  lsp_keymaps()
end

M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
