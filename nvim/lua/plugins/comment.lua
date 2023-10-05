return {
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            mappings = { extra = false },
        },
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },
}
