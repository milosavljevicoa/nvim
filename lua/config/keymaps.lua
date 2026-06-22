-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

--Escape
map("n", "<leader>'", ":noh<CR>", { desc = "Clear search highlight" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Helix - Better navigation
map({ "v", "n" }, "gl", "$", { desc = "Go to end of line" })
map({ "v", "n" }, "gs", "^", { desc = "Go to start of line" })
map({ "v", "n" }, "mm", "%", { desc = "Jump to matching bracket" })
map({ "v", "n" }, "gp", "<C-^>", { desc = "Go to alternate file" })

-- Copy and paste
map("v", "<leader>yc", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>yy", "yiw", { desc = "Yank inner word" })
map("n", "<leader>yP", "viwp", { desc = "Replace word with paste" })
map({ "v", "n" }, "<leader>yp", "viwpgvy", { desc = "Paste over word (keep register)" })
