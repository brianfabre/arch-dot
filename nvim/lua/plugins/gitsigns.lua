local M = {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
            vim.keymap.set(
                "n",
                "<leader>gh",
                require("gitsigns").preview_hunk,
                { buffer = bufnr, desc = "preview git hunk" }
            )
        end,
    },
}

return M
