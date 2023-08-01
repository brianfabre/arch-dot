return {
    "anuvyklack/pretty-fold.nvim",
    config = function()
        require("pretty-fold").setup({
            -- keep_indentation = false,
            fill_char = " ",
            remove_fold_markers = false,
            sections = {
                left = {
                    "content",
                    -- function()
                    --     return string.rep("•", vim.v.foldlevel)
                    -- end,
                    -- "•••",
                    "󰁂 ",
                    "number_of_folded_lines",
                    " •••",
                },
            },
        })
    end,
}
