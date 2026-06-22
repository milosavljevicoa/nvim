return {
    {
        "folke/flash.nvim",
        keys = {
            { "s", mode = { "n", "x", "o" }, false },
            { "S", mode = { "n", "x", "o" }, false },

            {
                "<leader>jj",
                function()
                    require("flash").jump()
                end,
                desc = "Jump",
            },

            {
                "<leader>yt",
                function()
                    require("flash").treesitter()
                end,
                desc = "Treesitter",
            },

            {
                "<leader>jl",
                function()
                    require("flash").jump({
                        search = { mode = "search", max_length = 0 },
                        label = { after = { 0, 0 } },
                        pattern = "^",
                    })
                end,
                desc = "Jump Line",
            },
        },
    },
}
