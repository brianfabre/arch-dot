return {
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        version = false,
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 50,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },
            }
        end,
    },
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "markdown", "neo-tree", "lazy" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = function()
            require("mini.indentscope").setup({
                symbol = "│",
                options = { try_as_border = true },
                draw = {
                    delay = 1,
                    animation = require("mini.indentscope").gen_animation.none(),
                },
            })
        end,
    },
}
