local M = {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    globalstatus = true,
                    theme = "auto",
                    -- component_separators = { left = "", right = "" },
                    -- section_separators = { left = "", right = "" },
                    component_separators = "|",
                    section_separators = "",
                    disabled_filetypes = {
                        statusline = { "alpha" },
                        winbar = {},
                    },
                },
                sections = {
                    lualine_a = {},
                    lualine_b = { "branch", "diff" },
                    lualine_c = {
                        {
                            "filename",
                            path = 2,
                        },
                    },
                    lualine_x = { "diagnostics", "filetype" },
                    lualine_y = { "location" },
                    lualine_z = {},
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end,
    },
}

return M
