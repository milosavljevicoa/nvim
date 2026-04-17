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


vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    }
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  }
})

local map = vim.keymap.set

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', 'gi', vim.lsp.buf.implementation, opts)
  map('n', 'GD', vim.lsp.buf.type_definition, opts)
  map({ 'i', 'n' }, '<c-l>', vim.lsp.buf.signature_help, opts)
  map({ 'v', 'n' }, '<leader>fr', function() vim.lsp.buf.format({ async = true }) end, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "<leader>ca", function()
    vim.lsp.buf.code_action({
      filter = function(action)
        return not action.disabled
      end
    })
  end, opts)
  map("n", "<leader>gl", vim.diagnostic.open_float, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "gj", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, opts)
  map("n", "gk", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Global defaults applied to every server
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
})

vim.lsp.config('ts_ls', {
  on_attach = function(client, bufnr)
    -- Semantic tokens are computed on every keystroke; treesitter covers
    -- syntax highlighting so we don't need them. This is the single biggest
    -- ts_ls speedup available in nvim.
    client.server_capabilities.semanticTokensProvider = nil
    on_attach(client, bufnr)
  end,
  init_options = {
    preferences = {
      allowIncompleteCompletions = true,        -- stream partial results
      includeCompletionsWithSnippetText = false, -- fewer completion items
      includeAutomaticOptionalChainCompletions = false,
      importModuleSpecifierPreference = 'relative',
    },
    -- Hard cap server memory to reduce GC pause frequency on large projects
    maxTsServerMemory = 4096,
  },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      inlayHints = {
        parameterHints = { enable = true },
        typeHints = { enable = true },
        chainingHints = { enable = true },
        maxLength = 25,
      },
    }
  }
})

vim.lsp.enable({ 'lua_ls', 'ts_ls', 'cssls', 'rust_analyzer' })
