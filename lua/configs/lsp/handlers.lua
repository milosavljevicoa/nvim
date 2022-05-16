local M = {}

local nmap = require("core.utils").nmap
local imap = require("core.utils").imap

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

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  nmap("gd", vim.lsp.buf.definition, opts)
  nmap("gD", vim.lsp.buf.declaration, opts)
  nmap("gi", vim.lsp.buf.implementation, opts)
  nmap("gr", vim.lsp.buf.references, opts)
  nmap("GD", vim.lsp.buf.type_definition, opts)
  nmap("K", vim.lsp.buf.hover, opts)

  nmap('<space>rn', vim.lsp.buf.rename, opts)
  nmap('<space>ca', vim.lsp.buf.code_action, opts)
  nmap('<space>f', vim.lsp.buf.formatting, opts)

  nmap("gl", vim.diagnostic.open_float, opts)
  nmap("gj", vim.lsp.diagnostic.goto_next, opts)
  nmap("gk", vim.lsp.diagnostic.goto_prev, opts)
end

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      pattern = "<buffer>",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      pattern = "<buffer>",
      callback = vim.lsp.buf.clear_references,
    })
  end
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" or client.name == "jsonls" or client.name == "html" or client.name == "sumneko_lua" then
    client.server_capabilities.document_formatting = false
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
-- M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities.textDocument.completion.completionItem.preselectSupport = true
-- M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- M.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
-- M.capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     "documentation",
--     "detail",
--     "additionalTextEdits",
--   },
-- }

return M
