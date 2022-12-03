local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local ls_status_ok, ls = pcall(require, "luasnip")
if not ls_status_ok then
  print("luasnip not loaded")
  return
end

-- local loader = require "luasnip/loaders/from_vscode"
-- loader.lazy_load()

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true
}
--
-- ls.snippets = {
-- }



require("configs.luasnip.rust")

print("hello v1")
-- next jump in snippet
map({ "i", "s" }, "<c-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, opts)

-- previous jump in snippet
map({ "i", "s" }, "<c-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, opts)

-- cycles through of options
map({ "i", "s" }, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, opts)
