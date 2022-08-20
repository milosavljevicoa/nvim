local M = {}

function M.config()
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    error("Hop not loaded")
    return
  end

  hop.setup();
end


function M.mappings(map, opts)
  map("n", "<leader>j", "<cmd>HopWord<CR>", opts)
  map("n", "<leader>l", "<cmd>HopLineStart<CR>", opts)
end

return M
