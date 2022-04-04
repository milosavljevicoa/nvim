local M = {}

vim.cmd [[
  augroup highlight_yank
      autocmd!
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 150})
  augroup end
]]

vim.cmd [[autocmd FileType harpoon setlocal wrap]]

return M
