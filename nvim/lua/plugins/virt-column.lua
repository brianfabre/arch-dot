return {
    "lukas-reineke/virt-column.nvim",
    -- enabled = false,
    config = function()
        require("virt-column").setup({
            virtcolumn = "95",
        })
    end,
}
