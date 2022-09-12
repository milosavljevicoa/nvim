local M = {}

function M.config()
  local status_ok, catppuccin = pcall(require, "catppuccin")
  if not status_ok then
    return
  end

  vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

  catppuccin.setup({
    transparent_background = false,
    term_colors = false,
    compile = {
      enabled = false,
      path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    styles = {
      comments = {},
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      -- For various plugins integrations see https://github.com/catppuccin/nvim#integrations
      leap = true,
      cmp = true,
      telescope = true,
    },
    color_overrides = {},
    highlight_overrides = {},
  })

  vim.cmd "colorscheme catppuccin"
end

return M
