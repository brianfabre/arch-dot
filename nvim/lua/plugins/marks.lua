return {
    "chentoast/marks.nvim",
    keys = "m",
    config = function()
        require("marks").setup({
            default_mappings = false,
            mappings = {
                set_next = "m,",
                next = "m;",
                -- preview = false,
                -- delete_buf = "mda",
                -- prev = "mq",
            },
        })
    end,
}
