local M = {}

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Easier command access
map("n", ";", ":", opts)
map("n", ":", ";", opts)
map("v", ";", ":", opts)
map("v", ":", ";", opts)

--Escape
map("i", "jk", "<Esc>", opts)

map("v", "/", "<ESC>/\\%V", opts)
map("n", "<leader>'", ":noh<CR>", opts)

-- Copy and paste
map("v", "<C-c>", '"+y', opts)
map("i", "<C-v>", '<Esc>\"+p', opts)

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
map("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<leader>bn", "<cmd>bnext<CR>", opts)
map("n", "<leader>bp", "<cmd>bprevious<CR>", opts)
map("n", "<leader>bd", "<cmd>bdelete<CR>", opts)

-- Move text up and down
map("n", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", opts)
map("n", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)


-- File switcher
-- Angular
map("n", "<A-h>", "<cmd>lua require('switcher').switch_to('html', 'spec')<CR>", opts)
map("n", "<A-t>", "<cmd>lua require('switcher').switch_to('ts', 'spec')<CR>", opts)
map("n", "<A-n>", "<cmd>lua require('switcher').switch_to('spec.ts', 'spec')<CR>", opts)
map("n", "<A-s>", "<cmd>lua require('switcher').switch_to('scss', 'spec')<CR>", opts)


local lua_files = {
  'configs.lsp.lspsaga',
  'configs.telescope',
  'configs.nvim-tree',
  'configs.comment',
  'configs.luasnip',
  'configs.personal',
  'configs.symbols-outline'
}

for _, lua_file in ipairs(lua_files) do
  require(lua_file).mappings(map, opts)
end

return M
