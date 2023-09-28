--------------------
----   NEOVIM   ----
--------------------

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
})

-- colorscheme
local function color(theme)
    vim.cmd("colorscheme " .. theme)
end
-- color("kanagawa")
-- color("sonokai")
-- color("tokyonight")
-- color("onedark")
-- color("rose-pine")
color("falcon")
-- color("material")
-- color("arctic") -- vscode colors
-- color("dracula")
-- color("catppuccin")

-- require
require("config")
