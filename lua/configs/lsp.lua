local lsp_config_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_config_ok then
  print("lspconfig failed to load")
  return
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  print("mason failed to load")
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  print("mason_lspconfig failed to load")
  return
end

mason.setup()
mason_lspconfig.setup()

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

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

local map = vim.keymap.set

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  map('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  map('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  map('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  map('n', 'GD', function() vim.lsp.buf.type_definition() end, opts)
  map('n', '<space>fr', function() vim.lsp.buf.format({ async = true }) end, opts)
  map('v', '<space>fr', function() vim.lsp.buf.format({ async = true }) end, opts)
  map("n", "K", function() vim.lsp.buf.hover() end, opts)
  map("n", "<leader>gs", function() vim.lsp.buf.signature_help() end, opts)
  map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  map("n", "<leader>gl", function() vim.diagnostic.open_float() end, opts)
  map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  map("n", "gj", function() vim.diagnostic.goto_next() end, opts)
  map("n", "gk", function() vim.diagnostic.goto_prev() end, opts)
end

lspconfig['sumneko_lua'].setup {
  on_attach = on_attach,
}

lspconfig['tsserver'].setup {
  on_attach = on_attach,
}

local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
  error("rust-tools not loaded")
  return
end

rust_tools.setup {
  server = {
    on_attach = on_attach,
  },
  inlay_hints = {
    auto = true,
    only_current_line = false,
    show_parameter_hints = true,
    parameter_hints_prefix = "<- ",
    other_hints_prefix = "=> ",
    max_len_align = false,
    max_len_align_padding = 1,
    right_align_padding = 7,
    highlight = "Comment",
  },
}
