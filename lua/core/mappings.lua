local M = {}

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

--[[
*       search for word under cursor
]]

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For mm to work to
map("n", "<leader>m", "m", opts)

-- Helix inspired mappings
map({"v", "n"}, "gl", "$", opts)
map({"v", "n"}, "gs", "^", opts)
map({"v", "n"}, "gh", "gg", opts)
map({"v", "n"}, "ge", "G", opts)
map({"v", "n"}, "mm", "%", opts)

-- Easier command access
map("n", ";", ":", opts)
map("n", ":", ";", opts)
map("v", ";", ":", opts)
map("v", ":", ";", opts)

--Escape
map("i", "jk", "<Esc>", opts)

-- Search inside visual
map("v", "/", "<ESC>/\\%V", opts)
map("n", "<leader>'", ":noh<CR>", opts)

-- Copy and paste
map("v", "<leader>cc", '"+y', opts)
map("i", "<C-v>", '<Esc>\"+p', opts)
map("n", "<C-v>", '\"+p', opts)

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
map("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Move text up and down
map("v", "J", "<Esc><cmd>m .+1<CR>gv", opts)
map("v", "K", "<Esc><cmd>m .-2<CR>gv", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- File switcher
-- Angular
map("n", "<A-h>", "<cmd>lua require('switcher').switch_to('html', 'spec')<CR>", opts)
map("n", "<A-t>", "<cmd>lua require('switcher').switch_to('ts', 'spec')<CR>", opts)
map("n", "<A-n>", "<cmd>lua require('switcher').switch_to('spec.ts', 'spec')<CR>", opts)
map("n", "<A-s>", "<cmd>lua require('switcher').switch_to('scss', 'spec')<CR>", opts)

local executeMappingns = function()
  local scan = require 'plenary.scandir'
  local utils = require 'core.utils'

  local suffix = utils.makePath({'lua', 'configs'})
  local configs = vim.fn.stdpath 'config' .. suffix
  local files = scan.scan_dir(configs, { hidden = false, depth = 2 })

  for _, file in ipairs(files) do
    file = string.sub(file, string.find(configs, suffix) + 5, string.len(file) - 4)

    local ok, customConfig = pcall(require, file)
    if ok and type(customConfig) == "table" and type(customConfig.mappings) == "function" then
      customConfig.mappings(map, opts)
    end
  end
end

executeMappingns()

return M
