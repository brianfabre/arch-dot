return {
    "lukas-reineke/virt-column.nvim",
    -- enabled = false,
    config = function()
        require("virt-column").setup({
            virtcolumn = "100",
        })
    end,
}
