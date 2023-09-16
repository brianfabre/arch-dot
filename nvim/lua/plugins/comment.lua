return {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
        mappings = { extra = false },
    },
    config = function(_, opts)
        require("Comment").setup(opts)
        vim.keymap.set("n", "<leader>/", ":normal gcc<cr>", { desc = "toggle comment line" })
        vim.keymap.set(
            "v",
            "<leader>/",
            "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
            { desc = "toggle comment selection" }
        )
    end,
}
