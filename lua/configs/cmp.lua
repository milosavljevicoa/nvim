local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print("cmp not find")
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  print("luasnip not found")
  return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
  print("lspkind not found")
  return
end

-- local kind_icons = {
--   Text = "",
--   Method = "",
--   Function = "",
--   Constructor = "",
--   Field = "",
--   Variable = "",
--   Class = "ﴯ",
--   Interface = "",
--   Module = "",
--   Property = "ﰠ",
--   Unit = "",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "",
--   Event = "",
--   Operator = "",
--   TypeParameter = ""
-- }

  -- formatting = {
  --   format = function(entry, vim_item)
  --     -- Kind icons
  --     vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
  --     -- Source
  --     vim_item.menu = ({
  --       buffer = "[Buffer]",
  --       nvim_lsp = "[LSP]",
  --       luasnip = "[LuaSnip]",
  --       nvim_lua = "[Lua]",
  --       latex_symbols = "[LaTeX]",
  --     })[entry.source.name]
  --     return vim_item
  --   end
  -- },


cmp.setup {
  performance = {
    debounce = 150,
    throttle = 60,      -- max rate after first trigger
    fetching_timeout = 200, -- give up on slow sources sooner
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false,
  },
  sources = cmp.config.sources({ -- Order matters on what completions you will see first
    {
      name = 'nvim_lsp',
      max_item_count = 60, -- ts_ls can return hundreds; cap to keep cmp fast
      entry_filter = function(entry)
        return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
      end
    },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 4 },
    { name = 'luasnip' },
  }),
  mapping = cmp.mapping.preset.insert({
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-b>'] = cmp.mapping.scroll_docs(4),
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-e>"] = cmp.mapping.complete(),
    ['<C-s>'] = cmp.mapping.complete({
      config = {
        sources = {
          { name = 'luasnip' }
        }
      }
    }),
    ["<Tab>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  }),
}

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
