local M = {}

function M.config()
  local status_ok, harpoon = pcall(require, "harpoon")
  if not status_ok then
    return
  end

  harpoon.setup()
end

function M.mappings(map, opts)
  map("n", "<leader>..", "<cmd>:lua require('harpoon.mark').add_file()<CR>", opts)
  map("n", "<leader>.e", "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
  map("n", "<leader>.h", "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", opts)
  map("n", "<leader>.t", "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", opts)
  map("n", "<leader>.n", "<cmd>:lua require('harpoon.ui').nav_file(3)<CR>", opts)
  map("n", "<leader>.s", "<cmd>:lua require('harpoon.ui').nav_file(4)<CR>", opts)
end

return M
