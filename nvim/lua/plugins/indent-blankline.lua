return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("ibl").setup({
            whitespace = {
                remove_blankline_trail = true,
            },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "markdown",
                    "vimwiki",
                    "neo-tree",
                    "lazy",
                },
            },
        })
    end,
}
