local M = {}

function M.config()
  local run = false
  if not run then
    return
  end

  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  -- Check supported formatters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting

  -- Check supported linters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    debug = false,
    sources = {
      -- diagnostics.eslint,
      formatting.stylua,
      formatting.prettier,
    },
  }
end

function M.mappings(map, opts)
  map("n", "<leader>fr", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

return M
