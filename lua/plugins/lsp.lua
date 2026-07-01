return {
    {
        "neovim/nvim-lspconfig",
        opts = { autoformat = false },
    },
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                -- You can use "default" to keep standard keys, or "none" to only use the ones below.
                -- "default" is recommended so you don't lose basic functionality.
                preset = "default",

                -- Scrolling documentation
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },

                -- Navigate items
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },

                -- Trigger completion menu
                ["<C-e>"] = { "show", "hide", "fallback" },

                -- Accept the selected item (select_and_accept works like cmp's ConfirmBehavior.Insert)
                ["<enter>"] = { "select_and_accept", "fallback" },

                -- Custom trigger for only the 'snippets' provider (luasnip/friendly-snippets)
                ["<C-s>"] = {
                    function(cmp)
                        cmp.show({ providers = { "snippets" } })
                    end,
                },
            },
        },
    },
}
