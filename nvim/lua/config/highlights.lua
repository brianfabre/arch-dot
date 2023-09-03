-- set spell
vim.api.nvim_set_hl(0, "SpellBad", {
    bg = "#FF0000",
    fg = "#FFFFFF",
})

-- flash.nvim
vim.api.nvim_set_hl(0, "FlashMatch", {
    bg = "#00FF00",
    fg = "#000000",
    bold = true,
})

vim.api.nvim_set_hl(0, "FlashLabel", {
    bg = "#FF0000",
    fg = "#FFFFFF",
    bold = true,
})

vim.api.nvim_set_hl(0, "FlashPrompt", {
    bg = "#FFFFFF",
    fg = "#0000FF",
    bold = true,
})

-- vim.cmd("highlight link WinSeparator FloatBorder")
