return {
    "tzachar/highlight-undo.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("highlight-undo").setup({
            hlgroup = "HighlightUndo",
            duration = 2000,
            keymaps = {
                { "n", "u", "undo", {} },
                { "n", "<C-r>", "redo", {} },
            },
        })
    end,
}
