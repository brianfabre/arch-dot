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
                b = { name = "buffer", _ = "which_key_ignore" },
                c = { name = "directory", _ = "which_key_ignore" },
                f = { name = "files", _ = "which_key_ignore" },
                g = { name = "git", _ = "which_key_ignore" },
                l = { name = "lsp / lazy(git)", _ = "which_key_ignore" },
                o = { name = "open", _ = "which_key_ignore" },
                p = { name = "run code", _ = "which_key_ignore" },
                q = { name = "quit", _ = "which_key_ignore" },
                r = { name = "rename lsp", _ = "which_key_ignore" },
                s = { name = "search fzf", _ = "which_key_ignore" },
                u = { name = "ui", _ = "which_key_ignore" },
                w = { name = "wiki", _ = "which_key_ignore" },
            }, { prefix = "<leader>" })
        end,
    },
}

return M
