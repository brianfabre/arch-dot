return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
        -- options
    },
    config = function()
        vim.api.nvim_set_hl(0, "FidgetTask", { link = "Comment" })
    end,
}
