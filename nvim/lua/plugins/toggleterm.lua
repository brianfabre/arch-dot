local M = {

    {
        "akinsho/toggleterm.nvim",
        -- keys = { "<leader>tl" },
        cmd = "ToggleTerm",
        version = "*",
        config = function()
            require("toggleterm").setup({
                close_on_exit = true,
                direction = "float",
                float_opts = {
                    border = "double",
                    width = function()
                        return math.floor(vim.o.columns * 0.9)
                    end,
                    height = function()
                        return math.floor(vim.o.lines * 0.9)
                    end,
                },
                -- function to run on opening the terminal
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(
                        term.bufnr,
                        "n",
                        "q",
                        "<cmd>close<CR>",
                        { noremap = true, silent = true }
                    )
                end,
                -- function to run on closing the terminal
                on_close = function(term)
                    vim.cmd("startinsert!")
                end,
            })
        end,
    },
}

return M
