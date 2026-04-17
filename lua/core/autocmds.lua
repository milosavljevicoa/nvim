vim.cmd [[
  augroup highlight_yank
      autocmd!
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 150})
  augroup end
]]

vim.cmd "autocmd FileType lua setlocal ts=2 sw=2 expandtab"

-- vim.cmd "colorscheme tokyonight-moon"
vim.cmd "colorscheme kanagawa-wave"

-- Set custom tab size for CSS
vim.api.nvim_create_autocmd("FileType", {
  pattern = "scss",
  callback = function()
    vim.opt_local.shiftwidth = 4   -- number of spaces used for each step of indent
    vim.opt_local.tabstop = 4      -- number of spaces a <Tab> counts for
    vim.opt_local.expandtab = true -- use spaces instead of tabs
  end,
})

