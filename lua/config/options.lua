-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt
opt.tabstop = 4 -- Number of spaces a TAB character displays as
opt.shiftwidth = 4 -- Number of spaces inserted for each indentation level
opt.softtabstop = 4 -- Number of spaces inserted when the TAB key is pressed
opt.expandtab = true -- Convert TABs to spaces

-- Disable LazyVim's auto root detection and just use the current working directory
vim.g.root_spec = { "cwd" }

-- Disable syncing to the system clipboard
vim.opt.clipboard = ""

-- Disable autoformat on save
vim.g.autoformat = false
