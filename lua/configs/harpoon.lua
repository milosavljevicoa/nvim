local M = {}


function M.mappings(map, opts)
  map("n", "<leader>..", "<cmd>:lua require('harpoon.mark').add_file()<CR>", opts)
  map("n", "<leader>.e", "<cmd>:lua require('harpoon.mark').toggle_quick_menu()<CR>", opts)
  map("n", "<leader>.h", "<cmd>:lua require('harpoon.mark').nav_file(1)<CR>", opts)
  map("n", "<leader>.t", "<cmd>:lua require('harpoon.mark').nav_file(2)<CR>", opts)
  map("n", "<leader>.n", "<cmd>:lua require('harpoon.mark').nav_file(3)<CR>", opts)
  map("n", "<leader>.s", "<cmd>:lua require('harpoon.mark').nav_file(4)<CR>", opts)
end

return
