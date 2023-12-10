local Util = require("config.utils")

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    -- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    vim.keymap.set(mode, lhs, rhs, options)
end

-- move between panes to left/bottom/top/right
-- enabled in vim-tmux-navigator plugin
-- map("n", "<C-h>", "<C-w>h")
-- map("n", "<C-l>", "<C-w>l")
-- map("n", "<C-j>", "<C-w>j")
-- map("n", "<C-k>", "<C-w>k")

-- jk for wrapped words
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- horizontal movement
map("n", "<S-left>", "^")
map("n", "<S-right>", "$")

-- cursor remains in position after yank
map("v", "y", "ygv<esc>")

-- netrw
map("n", "<leader>v", ":Lexplore<CR>", { desc = "netrw" })

-- windows
-- map("n", "<leader>wo", "<C-W>p", { desc = "other window" })
map("n", "<leader>dw", "<C-W>c", { desc = "[d]elete [w]indow" })
-- map("n", "<leader>w-", "<C-W>s", { desc = "split window below" })
-- map("n", "<leader>w|", "<C-W>v", { desc = "split window right" })

-- move between buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
-- map("n", "<Leader>qq", ":bp | bd! #<CR>", { desc = "quit buffer" })
map("n", "<Leader>qa", ":%bd|e#<CR>:bnext<CR>:bd<CR>e", { desc = "quit all other buffers" })

-- move line/down
map("n", "<S-Up>", ":m-2<CR>")
map("n", "<S-Down>", ":m+<CR>")
map("v", "<S-Up>", ":m '<-2<CR>gv=gv")
map("v", "<S-Down>", ":m '>+1<CR>gv=gv")

-- copy to clipboard
-- map("v", "<Leader>y", '"*y')
map("v", "<Leader>y", '"+y')

-- no register for x
map("n", "x", '"_x')

-- leave insert mode
map("i", "jk", "<esc>")
-- map("t", "jk", "<C-\\><C-n>") -- interferes with lazygit.nvim or other terminal plugins
map("t", "<Esc>", "<C-\\><C-n>")

-- save
map("n", "<leader>k", ":update<CR>", { desc = "save" })

-- quit all
-- map("n", "<leader>qp", ":qa!<CR>", { desc = "quit neovim" })

-- file path
map("n", "<leader>cw", ":lua print(vim.fn.getcwd())<CR>", { desc = "echo CWD" })
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { desc = "set as working dir" })
map("n", "<leader>cp", ':let @+=expand("%:p")<CR>', { desc = "path to clipboard" })

-- always centers after c-d/c-u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- faster in/outdenting
map("i", "<<", "<c-d>")
map("i", ">>", "<c-t>")

-- allow the . to execute once for each line of a visual selection
map("v", ".", ":normal .<CR>")

-- open lazy.nvim
map("n", "<leader>lz", ":Lazy<CR>", { desc = "lazy.nvim" })

-- open nvim config
map("n", "<leader>oc", ":e $MYVIMRC<CR>", { desc = "config" })

-- resize windows
-- map("n", "<leader>=", ':exe "resize +2"<CR>', { desc = "win size increase" })
-- map("n", "<leader>-", ':exe "resize -2"<CR>', { desc = "win size decrease" })
-- map("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
-- map("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
-- map("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
-- map("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

-- ui stuff
map("n", "<leader>us", ":set invspell<CR>", { desc = "toggle spelling" })
map("n", "<leader>uw", ":set wrap!<CR>", { desc = "toggle word wrap" })

-- fastwrap
-- map("i", "<C-e>", "<esc>lxep<esc>i")

map("n", "<leader>\\", ":lua require('config/utils').FindAll()<CR>", { desc = "quickfix search" })
map("n", "<leader>ur", ":lua require('config/utils').SearchReplace()<CR>", { desc = "search and replace" })

-- toggle all folds
map("n", "<leader>.", "zA", { desc = "search and replace" })

-- if BOL, press h to close fold
vim.keymap.set("n", "h", function()
    local onIndentOrFirstNonBlank = vim.fn.virtcol(".") <= vim.fn.indent(".") + 1 ---@diagnostic disable-line: param-type-mismatch
    local shouldCloseFold = vim.tbl_contains(vim.opt_local.foldopen:get(), "hor")
    if onIndentOrFirstNonBlank and shouldCloseFold then
        local wasFolded = pcall(vim.cmd.normal, "zc")
        if wasFolded then
            return
        end
    end
    vim.cmd.normal({ "h", bang = true })
end, { desc = "h (+ close fold at BoL)" })
