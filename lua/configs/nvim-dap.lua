local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local status_dap_ok, dap = pcall(require, "dap")
local status_dap_ui_ok, dap_ui = pcall(require, "dap-ui")
local status_dap_virtual_text_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")

if not status_dap_ok then
  print "dap not found..."
  return
end
if not status_dap_ui_ok then
  -- print "dap-ui not found..."
  return
end
if not status_dap_virtual_text_ok then
  print "nvim-dap-virtual-text not found..."
  return
end

dap_virtual_text.setup {}


map("n", "<leader>b", "<cmd>:lua require('dap').toggle_breakpoint()<CR>", opts)
map("n", "<F5>", "<cmd>:lua require('dap').continue()<CR>", opts)
map("n", "<F10>", "<cmd>:lua require('dap').step_over()<CR>", opts)
map("n", "<F11>", "<cmd>:lua require('dap').step_into()<CR>", opts)
