local ls = require "luasnip"
local snippet_collection = require "luasnip.session.snippet_collection"

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local same = require("configs.luasnip.helper").same

local fmt = require("luasnip.extras.fmt").fmt

snippet_collection.clear_snippets "rust"

ls.add_snippets("rust", {
  s(
    "tests",
    fmt([[
#[cfg(test)]
mod tests {{
    use super::*;

    #[test]
    fn {}() {{
      {}
    }}
}}
]]   , { i(1), i(2) })),
  s(
    "test",
    fmt([[
    #[test]
    fn {}() {{
      {}
    }}
]]   , { i(1), i(2) })),
  s("eq", fmt("assert_eq!({}, {});{}", { i(1), i(2), i(0) })),
  s("enum", {
    t { "#[derive(Debug, PartialEq)]", "enum " },
    i(1, "Name"),
    t { " {", "  " },
    i(0),
    t { "", "}" },
  }),

  s("struct", {
    t { "#[derive(Debug, PartialEq)]", "struct " },
    i(1, "Name"),
    t { " {", "    " },
    i(0),
    t { "", "}" },
  }),
  s("pd", fmt([[println!("{}: {{:?}}", {});]], { same(1), i(1) })),
})
