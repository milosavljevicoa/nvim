local M = {}

function M.config()
  local status_ok, saga = pcall(require, "lspsaga")
  if not status_ok then
    return
  end

  saga.init_lsp_saga({
    finder_action_keys = {
      open = { 'o', '<cr>' },
      vsplit = 'v',
      split = 's',
      quit = { 'q', '<ESC>', "<C-c>" },
      --[[ scroll_down = '<C-f>', ]]
      --[[ scroll_up = '<C-b>', ]]
      -- quit can be a table
    },
    code_action_keys = {
      quit = { 'q', '<ESC>', "<C-c>" },
    },
  })
end

function M.mappings(map, opts)

  map('n', 'gr', '<Cmd>Lspsaga lsp_finder<CR>', opts)
  map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  map("n", "<leader>gs", "<Cmd>Lspsaga signature_help<CR>", opts)
  map("n", "<leader>gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  --[[ map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) ]]
  map("n", "<leader>ca", function ()
    vim.lsp.buf.code_action()
  end, opts)
  map("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
  map("n", "<leader>gd", "<Cmd>Lspsaga preview_definition<CR>", opts)

  local diagnostic = require("lspsaga.diagnostic")
  map("n", "gj", diagnostic.goto_next, opts)
  map("n", "gk", diagnostic.goto_prev, opts)
end

return M
