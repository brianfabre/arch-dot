return {
    "chentoast/marks.nvim",
    keys = "m",
    config = function()
        require("marks").setup({
            mappings = {
                preview = false,
                delete_buf = "mda",
                next = "mw",
                prev = "mq",
            },
        })
    end,
}
