return {
    {
        "lewis6991/gitsigns.nvim",
        keys = {
            {
                "GJ",
                "<cmd>Gitsigns next_hunk<CR>",
                desc = "Go to next hunk",
            },
            {
                "GK",
                "<cmd>Gitsigns prev_hunk<CR>",
                desc = "Go to previous hunk",
            },
            {
                "GL",
                "<cmd>Gitsigns preview_hunk_inline<CR>",
                desc = "Inline hunk",
            },
            {
                "GR",
                "<cmd>Gitsigns reset_hunk<CR>",
                desc = "Reset hunk",
            },
        },
    },
}
