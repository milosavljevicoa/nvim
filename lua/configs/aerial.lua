-- https://github.com/stevearc/aerial.nvim
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
  return
end

aerial.setup {
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
}

-- You probably also want to set a keymap to toggle aerial
map("n", "<leader>a", "<cmd>AerialToggle!<CR>", opts)
