local M = {

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require("which-key").setup({
                plugins = {
                    spelling = {
                        enabled = true,
                    },
                },
                window = {
                    border = "single",
                },
                -- ignore_missing = true,
            })

            local wk = require("which-key")
            wk.register({
                b = { name = "buffer" },
                c = { name = "directory" },
                f = { name = "files" },
                o = { name = "open ..." },
                p = { name = "run code" },
                q = { name = "quit ..." },
                s = { name = "search ..." },
                u = { name = "ui" },
                w = { name = "windows / wiki" },
            }, { prefix = "<leader>" })
        end,
    },
}

return M
