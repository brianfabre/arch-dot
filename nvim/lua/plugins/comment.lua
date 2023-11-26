return {
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            mappings = { extra = false },
        },
        config = function()
            local api = require("Comment.api")
            vim.keymap.set("n", "<leader>/", api.call("toggle.linewise.current", "g@$"), { expr = true })
            vim.keymap.set("x", "<leader>/", function()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
                api.toggle.linewise(vim.fn.visualmode())
            end)
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },
}
