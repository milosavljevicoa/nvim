local M = {}

function M.config()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    error("cmp not find")
    return
  end

  local snip_status_ok, luasnip = pcall(require, "luasnip")
  if not snip_status_ok then
    error("luasnip not found")
    return
  end

  local lspkind_status_ok, lspkind = pcall(require, "lspkind")
  if not lspkind_status_ok then
    error("lspkind not found")
    return
  end

  cmp.setup {
    performance = {
      debounce = 150,
    },
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol_text',
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        with_text = true,
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
      native_menu = false,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer", keword_lenght = 4 },
    }),
    mapping = cmp.mapping.preset.insert({
      ['<C-g>'] = cmp.mapping.scroll_docs(-4),
      ['<C-m>'] = cmp.mapping.scroll_docs(4),
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ['<C-s>'] = cmp.mapping.complete({
        config = {
          sources = {
            { name = 'luasnip' }
          }
        }
      }),
      ["<C-e>"] = cmp.mapping.complete(),
      ["<Tab>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
    }),
  }
end

return M
