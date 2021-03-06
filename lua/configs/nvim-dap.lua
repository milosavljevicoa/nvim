local M = {}

function M.config()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    print "Dap not found..."
    return
  end

  dap.adapters.python = {
    type = 'executable';
    command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
    args = { '-m', 'debugpy.adapter' };
  }

end

function M.mappings(map, opts)
  map("n", "<leader>b", "<cmd>:lua require('dap').toggle_breakpoint()<CR>", opts)
  map("n", "<F5>", "<cmd>:lua require('dap').continue()<CR>", opts)
  map("n", "<F10>", "<cmd>:lua require('dap').step_over()<CR>", opts)
  map("n", "<F11>", "<cmd>:lua require('dap').step_into()<CR>", opts)
end

return M
