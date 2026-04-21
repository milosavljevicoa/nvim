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

local function go_to_definition()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local encoding = clients[1] and clients[1].offset_encoding or 'utf-8'
  local params = vim.lsp.util.make_position_params(vim.api.nvim_get_current_win(), encoding)
  vim.lsp.buf_request_all(0, 'textDocument/definition', params, function(results)
    local locations = {}
    for _, result in pairs(results) do
      if result.result then
        local locs = vim.islist(result.result) and result.result or { result.result }
        vim.list_extend(locations, locs)
      end
    end

    local non_node = vim.tbl_filter(function(loc)
      local uri = loc.uri or loc.targetUri or ''
      return not uri:find('node_modules', 1, true)
    end, locations)

    local final = #non_node > 0 and non_node or locations
    if #final == 0 then return end

    if #final == 1 then
      vim.lsp.util.show_document(final[1], 'utf-8', { focus = true })
    else
      vim.fn.setqflist({}, ' ', {
        title = 'LSP Definitions',
        items = vim.lsp.util.locations_to_items(final, 'utf-8'),
      })
      vim.cmd('copen')
    end
  end)
end

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  map('n', 'gd', go_to_definition, opts)
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
