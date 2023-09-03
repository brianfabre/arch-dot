local M = {

    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
        opts = { transparent = true },
    },
    {
        "catppuccin/nvim",
        lazy = true,
        priority = 1000,
        name = "catppuccin",
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            -- term_colors = true,
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = { style = "moon" },
        config = function()
            require("tokyonight").setup({
                transparent = true,
                -- other configs
                on_colors = function(colors)
                    colors.border = "#565f89"
                end,
            })
        end,
    },
    {
        "Mofiqul/dracula.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            local dracula = require("dracula")
            dracula.setup({
                transparent_bg = true, -- default false
                -- set italic comment
                italic_comment = true, -- default false
                overrides = {
                    -- Examples
                    -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
                    -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
                    -- Nothing = {} -- clear highlight of Nothing
                    htmlH1 = { fg = dracula.colors().cyan, underline = true, bold = true },
                    htmlH2 = { fg = dracula.colors().pink, underline = true, bold = true },
                    htmlH3 = { fg = dracula.colors().green, underline = true, bold = true },
                    htmlH4 = { fg = dracula.colors().orange, underline = true, bold = true },
                    htmlH5 = { fg = dracula.colors().purple, underline = true, bold = true },
                    htmlH6 = { fg = dracula.colors().yellow, underline = true, bold = true },
                    htmlItalic = { fg = dracula.colors().purple, italic = true },
                    htmlLink = { fg = dracula.colors().orange, underline = true },
                    htmlBoldItalic = { fg = dracula.colors().green, bold = true, italic = true },
                    -- Comment = { fg = dracula.colors().comment },
                    Comment = { fg = "#A9A9A9", italic = true },
                },
            })

            -- -- should be called later?
            -- vim.api.nvim_set_hl(0, "Folded", { fg = "#ABB2BF" })
            -- vim.api.nvim_set_hl(0, "Visual", { bg = "#A9A9A9", fg = "#282A36" })
        end,
    },
    {
        "sainnhe/sonokai",
        lazy = true,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = "atlantis"
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_transparent_background = 1
        end,
    },
    {
        "echasnovski/mini.base16",
        lazy = true,
        priority = 1000,
        config = function()
            require("mini.base16").setup({
                palette = require("mini.base16").mini_palette("#112641", "#e2e98f", 75),
                -- palette = {
                -- },
                name = "minischeme",
            })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = "", bg = "" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#112641" })
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            require("vscode").setup({
                -- transparent = true,
                italic_comments = true,
                disable_nvimtree_bg = true,
            })
            -- require("vscode").load()
        end,
    },
}

return M
