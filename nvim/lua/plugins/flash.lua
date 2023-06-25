return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        {
            search = {
                exclude = {
                    "notify",
                    "cmp_menu",
                    "alpha",
                    function(win)
                        -- exclude non-focusable windows
                        return not vim.api.nvim_win_get_config(win).focusable
                    end,
                },
            },
            jump = {
                autojump = true,
            },
        },
    },
    keys = {
        -- {
        --     "s",
        --     mode = { "n", "x", "o" },
        --     function()
        --         -- default options: exact mode, multi window, all directions, with a backdrop
        --         require("flash").jump()
        --     end,
        --     desc = "Flash",
        -- },
        {
            "S",
            mode = { "n", "o", "x" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        -- {
        --     "r",
        --     mode = "o",
        --     function()
        --         require("flash").remote()
        --     end,
        --     desc = "Remote Flash",
        -- },
    },
}
