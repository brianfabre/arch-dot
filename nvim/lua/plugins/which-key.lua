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
                c = { name = "directory" },
                f = { name = "files" },
                -- o = { name = "Open ...", g = { "Lazygit" } },
                o = { name = "open ..." },
                p = { name = "run code" },
                q = { name = "quit ..." },
                s = { name = "search ..." },
                -- s = {
                --     name = "Search ...",
                --     p = { ":cd ~/.local/share/nvim/lazy<CR> :Telescope find_files <CR>", "Plugins" },
                --     c = {
                --         ':cd ~/.config<CR> :lua require"telescope.builtin".find_files({ hidden = true })<CR>',
                --         "Config",
                --     },
                --     r = { ":cd /Volumes/Bob/R<CR> :Telescope find_files <CR>", "R" },
                --     s = { ":cd ~/Documents/Stata<CR> :Telescope find_files <CR>", "Stata" },
                --     l = { ":cd /Volumes/Bob/Latex<CR> :Telescope find_files <CR>", "Latex" },
                --     d = { ":cd ~/Documents<CR> :Telescope find_files <CR>", "Documents" },
                --     -- p = { ":cd ~/Documents/PycharmProjects<CR> :Telescope find_files <CR>", "Pycharm search" },
                -- },
                u = { name = "ui" },
                w = { name = "Windows / Wiki" },
            }, { prefix = "<leader>" })
        end,
    },
}

return M
