local M = {}

function M.config()
  local status_ok, saga = pcall(require, "lspsaga")
  if not status_ok then
    return
  end

  saga.init_lsp_saga()

end

function M.mappings(map, opts)

  map('n', 'gr', '<Cmd>Lspsaga lsp_finder<CR>', opts)
  map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  map("n", "gs", "<Cmd>Lspsaga signature_help<CR>", opts)
  map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  map("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)
  map("n", "<leader>gd", "<Cmd>Lspsaga preview_definition<CR>", opts)
  map("n", "<leader>o", "<cmd>Lspsaga LSoutlineToggle<CR>", opts)

  local action = require("lspsaga.action")
  -- scroll down hover doc or scroll in definition preview
  map("n", "<C-f>", function() action.smart_scroll_with_saga(1) end, opts)
  -- scroll up hover doc
  map("n", "<C-b>", function() action.smart_scroll_with_saga(-1) end, opts)

  local diagnostic = require("lspsaga.diagnostic")
  map("n", "gj", diagnostic.goto_next, opts)
  map("n", "gk", diagnostic.goto_prev, opts)
end

return M
