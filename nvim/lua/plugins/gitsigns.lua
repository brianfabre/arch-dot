local M = {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
