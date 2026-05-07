-- @tag.builtin (lowercase HTML elements like <div>) has no default highlight
-- link in Neovim, while @tag (uppercase components) links to the Tag vim group.
-- This makes them consistent.
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   group = vim.api.nvim_create_augroup("fix_jsx_tag_hl", { clear = true }),
--   callback = function()
--     vim.api.nvim_set_hl(0, "@tag.builtin", { link = "@tag" })
--   end,
-- })
-- -- Apply immediately for the initial colorscheme load
-- vim.api.nvim_set_hl(0, "@tag.builtin", { link = "@tag" })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("filetype_lua", { clear = true }),
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("filetype_scss", { clear = true }),
  pattern = "scss",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end,
})
