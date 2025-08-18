local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
  print("Neogit not loaded")
  return
end

neogit.setup()
