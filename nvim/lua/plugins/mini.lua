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
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "lazy",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },

    {
        "echasnovski/mini.bufremove",
        keys = {
            {
                "<leader>db",
                function()
                    require("mini.bufremove").delete(0, false)
                end,
                desc = "[d]elete [b]uffer",
            },
            {
                "<leader>dB",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "[d]elete [b]uffer (force)",
            },
        },
    },
    {
        "echasnovski/mini.files",
        version = false,
        keys = {
            {
                "-",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
                end,
                desc = "open mini files",
            },
        },
        opts = {
            mappings = {
                go_in_plus = "<CR>",
            },
        },
    },
}
