-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

--Escape
map("n", "<leader>'", ":noh<CR>", opts)
map("i", "jk", "<Esc>", opts)

-- Helix - Better navigation
map({ "v", "n" }, "gl", "$", opts)
map({ "v", "n" }, "gs", "^", opts)
map({ "v", "n" }, "mm", "%", opts)
map({ "v", "n" }, "gp", "<C-^>", opts)
