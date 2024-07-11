function test_selection() 
  local line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
  local line2 = vim.api.nvim_buf_get_mark(0, ">")[1]

end
