local M = {}

local ls_status_ok, ls = pcall(require, "luasnip")
if not ls_status_ok then
  return
end

function M.config()
  local loader = require "luasnip/loaders/from_vscode"
  loader.lazy_load()

  ls.config.set_config {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    enable_autosnippets = true
  }
end

function M.mappings(map, opts)
  vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })
end

return M;
