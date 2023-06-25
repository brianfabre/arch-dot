return {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
        cmdline = {
            enabled = true, -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            -- view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        },
        -- presets = {
        --     bottom_search = true,
        --     command_palette = true,
        --     long_message_to_split = true,
        -- },
    },
}
