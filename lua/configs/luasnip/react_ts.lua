local ls = require "luasnip"
local snippet_collection = require "luasnip.session.snippet_collection"

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local same = require("configs.luasnip.helper").same

local fmt = require("luasnip.extras.fmt").fmt

snippet_collection.clear_snippets "typescriptreact"
snippet_collection.clear_snippets "typescript"

-- ── React (typescriptreact) ──────────────────────────────────────────

ls.add_snippets("typescriptreact", {

  -- Functional component
  s("rfc", fmt([[
import React from 'react';

interface {}Props {{
  {}
}}

const {}: React.FC<{}Props> = ({{{}}}) => {{
  return (
    <div>
      {}
    </div>
  );
}};

export default {};
]], { i(1, "Component"), i(2), same(1), same(1), i(3), i(0), same(1) })),

  -- Functional component (no props)
  s("rfce", fmt([[
import React from 'react';

const {} = () => {{
  return (
    <div>
      {}
    </div>
  );
}};

export default {};
]], { i(1, "Component"), i(0), same(1) })),

  -- useState
  s("us", fmt("const [{}, set{}] = useState<{}>({});", {
    i(1, "state"),
    i(2, "State"),
    i(3, "type"),
    i(0),
  })),

  -- useEffect
  s("ue", fmt([[
useEffect(() => {{
  {}
}}, [{}]);
]], { i(1), i(0) })),

  -- useEffect with cleanup
  s("uec", fmt([[
useEffect(() => {{
  {}
  return () => {{
    {}
  }};
}}, [{}]);
]], { i(1), i(2), i(0) })),

  -- useRef
  s("ur", fmt("const {} = useRef<{}>({});", { i(1, "ref"), i(2, "HTMLDivElement"), i(0, "null") })),

  -- useCallback
  s("ucb", fmt([[
const {} = useCallback(({}) => {{
  {}
}}, [{}]);
]], { i(1, "handler"), i(2), i(3), i(0) })),

  -- useMemo
  s("um", fmt([[
const {} = useMemo(() => {{
  {}
}}, [{}]);
]], { i(1, "value"), i(2), i(0) })),

  -- useContext
  s("uc", fmt("const {} = useContext({});", { i(1, "value"), i(0, "Context") })),

  -- Custom hook
  s("hook", fmt([[
import {{ {} }} from 'react';

const use{}  = ({}) => {{
  {}
  return {{{}}};
}};

export default use{};
]], { i(1, "useState"), i(2, "Hook"), i(3), i(4), i(5), same(2) })),

  -- React.memo
  s("memo", fmt([[
const {} = React.memo(({}: {}Props) => {{
  return (
    <div>
      {}
    </div>
  );
}});
]], { i(1, "Component"), i(2, "props"), same(1), i(0) })),

  -- forwardRef
  s("fref", fmt([[
const {} = React.forwardRef<{}, {}Props>(({}, ref) => {{
  return <div ref={{ref}}>{}</div>;
}});
]], { i(1, "Component"), i(2, "HTMLDivElement"), same(1), i(3, "props"), i(0) })),

  -- Event handler (onClick, onChange, etc.)
  s("handler", fmt([[
const handle{} = ({}: React.{}Event<{}>) => {{
  {}
}};
]], {
    i(1, "Click"),
    i(2, "e"),
    c(3, { t "Mouse", t "Change", t "KeyBoard", t "Form", t "Focus" }),
    i(4, "HTMLButtonElement"),
    i(0),
  })),
})

-- ── TypeScript (typescript + typescriptreact shared) ─────────────────

local ts_snippets = {

  -- Interface
  s("int", fmt([[
interface {} {{
  {}
}}
]], { i(1, "Name"), i(0) })),

  -- Type alias
  s("typ", fmt("type {} = {};", { i(1, "Name"), i(0) })),

  -- Enum
  s("enm", fmt([[
enum {} {{
  {} = "{}",
}}
]], { i(1, "Name"), i(2, "Value"), same(2) })),

  -- Generic function
  s("gfn", fmt([[
function {}<{}>({}: {}): {} {{
  {}
}}
]], { i(1, "name"), i(2, "T"), i(3, "arg"), same(2), i(4, "void"), i(0) })),

  -- Arrow function
  s("af", fmt("const {} = ({}: {}): {} => {};", { i(1, "fn"), i(2, "arg"), i(3, "type"), i(4, "void"), i(0) })),

  -- Async arrow function
  s("aaf", fmt([[
const {} = async ({}): Promise<{}> => {{
  {}
}};
]], { i(1, "fn"), i(2), i(3, "void"), i(0) })),

  -- Try/catch
  s("tc", fmt([[
try {{
  {}
}} catch (error) {{
  {}
}}
]], { i(1), i(0) })),

  -- Console.log with label
  s("cl", fmt('console.log("{}");', { i(0) })),

  -- Console.error
  s("ce", fmt('console.error("{}: ", {});', { same(1), i(1) })),

  -- Optional chaining + nullish coalescing
  s("opc", fmt("{}?.{} ?? {};", { i(1, "obj"), i(2, "prop"), i(0) })),

  -- Type assertion
  s("as", fmt("({} as {});", { i(1, "value"), i(0, "Type") })),

  -- Non-null assertion
  s("nn", fmt("{}!;", { i(0) })),

  -- Readonly array
  s("roa", fmt("ReadonlyArray<{}>;", { i(0, "Type") })),

  -- Record type
  s("rec", fmt("Record<{}, {}>;", { i(1, "string"), i(0, "unknown") })),

  -- Partial / Required / Pick / Omit
  s("partial", fmt("Partial<{}>;", { i(0, "Type") })),
  s("pick", fmt("Pick<{}, {}>;", { i(1, "Type"), i(0, "'key'") })),
  s("omit", fmt("Omit<{}, {}>;", { i(1, "Type"), i(0, "'key'") })),

  -- Promise.all
  s("pall", fmt([[
const [{}] = await Promise.all([
  {},
]);
]], { i(1, "results"), i(0) })),

  -- Import named
  s("imp", fmt("import {{ {} }} from '{}';", { i(1), i(0) })),

  -- Import default
  s("impd", fmt("import {} from '{}';", { i(1), i(0) })),
}

ls.add_snippets("typescript", ts_snippets)
ls.add_snippets("typescriptreact", ts_snippets)
