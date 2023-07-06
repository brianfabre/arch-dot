return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
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
        modes = {
            char = {
                -- set to `false` to use the current line only
                multi_line = false,
                highlight = { backdrop = false },
            },
        },
    },
}
