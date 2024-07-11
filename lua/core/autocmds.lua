vim.cmd [[
  augroup highlight_yank
      autocmd!
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 150})
  augroup end
]]

vim.cmd "autocmd FileType lua setlocal ts=2 sw=2 expandtab"

-- vim.cmd "colorscheme tokyonight-moon"
vim.cmd "colorscheme kanagawa-wave"
