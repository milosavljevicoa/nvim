local opts = { noremap = true, silent = true }
local map = vim.keymap.set

  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    print("Hop not loaded")
    return
  end

  hop.setup();


map("n", "<leader>j", "<cmd>HopWord<CR>", opts)
map("n", "<leader>l", "<cmd>HopLineStart<CR>", opts)
