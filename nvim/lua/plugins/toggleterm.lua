local M = {

    {
        "akinsho/toggleterm.nvim",
        keys = { "<leader>ol" },
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

            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "none",
                    width = 100000,
                    height = 100000,
                },
                -- on_open = function(_)
                --     vim.cmd("startinsert!")
                --     -- vim.cmd "set laststatus=0"
                -- end,
                -- on_close = function(_)
                --     -- vim.cmd "set laststatus=3"
                -- end,
                count = 99,
            })

            function _LAZYGIT_TOGGLE()
                lazygit:toggle()
            end
            vim.keymap.set("n", "<leader>ol", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })

            -- local Terminal = require("toggleterm.terminal").Terminal
            -- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
            -- -- local lf = Terminal:new({ cmd = "lf", hidden = true })
            --
            -- function _lazygit_toggle()
            --     lazygit:toggle()
            -- end
            --
            -- -- vim.api.nvim_set_keymap(
            -- vim.keymap.set("n", "<leader>ol", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
        end,
    },
}

return M
