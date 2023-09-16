-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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

require("lazy").setup({
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            mappings = { extra = false },
        },
    },
}, {
    change_detection = {
        notify = false,
    },
})

-- set iskeyword+=-
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "Filetype" }, {
    pattern = { "*" },
    command = "set iskeyword+=-",
})

-- move line/down
map("n", "<S-Up>", ":m-2<CR>")
map("n", "<S-Down>", ":m+<CR>")
map("v", "<S-Up>", ":m '<-2<CR>gv=gv")
map("v", "<S-Down>", ":m '>+1<CR>gv=gv")

-- leave insert mode
map("i", "jk", "<esc>")
map("t", "jk", "<C-\\><C-n>")
map("t", "<Esc>", "<C-\\><C-n>")

-- faster in/outdenting
map("i", "<<", "<c-d>")
map("i", ">>", "<c-t>")
