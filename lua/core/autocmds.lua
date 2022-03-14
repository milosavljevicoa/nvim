local M = {}

local colorscheme = "gruvbox-material",

vim.cmd [[
  augroup highlight_yank
      autocmd!
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 150})
  augroup end
]]

vim.cmd(string.format(
  [[
    augroup colorscheme
      autocmd!
      autocmd VimEnter * colorscheme %s
    augroup end]],
  colorscheme
))

vim.cmd [[autocmd FileType harpoon setlocal wrap]]

return M
