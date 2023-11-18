return {
    "Vigemus/iron.nvim",
    cmd = "IronRepl",
    -- appears on whichkey even if not loaded
    -- keys = {
    --     { "<leader>is", "<cmd>IronRepl<cr>", desc = "start iron" },
    --     { "<leader>ir", "<cmd>IronRestart<cr>", desc = "restart iron" },
    --     { "<leader>if", "<cmd>IronFocus<cr>", desc = "focus iron" },
    --     { "<leader>ih", "<cmd>IronHide<cr>", desc = "hide iron" },
    -- },
    config = function()
        local iron = require("iron.core")

        iron.setup({
            config = {
                -- Whether a repl should be discarded or not
                scratch_repl = true,
                -- Your repl definitions come here
                -- repl_definition = {
                --     sh = {
                --         -- Can be a table or a function that
                --         -- returns a table (see below)
                --         command = { "zsh" },
                --     },
                -- },
                repl_definition = {
                    python = require("iron.fts.python").ipython,
                },
                -- How the repl window will be displayed
                -- See below for more information
                repl_open_cmd = require("iron.view").split("33%"),
            },
            -- Iron doesn't set keymaps by default anymore.
            -- You can set them here or manually add keymaps to the functions in iron.core
            keymaps = {
                send_motion = "<localleader>sc",
                visual_send = "<localleader>sd",
                send_line = "<localleader>d",
                -- send_file = "<space>sf",
                -- send_until_cursor = "<space>su",
                -- send_mark = "<space>sm",
                -- mark_motion = "<space>mc",
                -- mark_visual = "<space>mc",
                -- remove_mark = "<space>md",
                -- cr = "<space>s<cr>",
                interrupt = "<space>s<space>",
                -- exit = "<space>sq",
                -- clear = "<space>cl",
            },
            -- If the highlight is on, you can change how it looks
            -- For the available options, check nvim_set_hl
            highlight = {
                italic = true,
            },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        })

        require("which-key").register({
            ["<leader>i"] = { name = "iron", _ = "which_key_ignore" },
        })
        vim.keymap.set("n", "<leader>is", "<cmd>IronRepl<cr>", { desc = "start iron" })
        vim.keymap.set("n", "<leader>ir", "<cmd>IronRestart<cr>", { desc = "restart iron" })
        vim.keymap.set("n", "<leader>if", "<cmd>IronFocus<cr>", { desc = "focus iron" })
        vim.keymap.set("n", "<leader>ih", "<cmd>IronHide<cr>", { desc = "hide iron" })
        -- vim.keymap.set("n", "<leader>rs", "<cmd>IronRepl<cr>")
        -- vim.keymap.set("n", "<leader>rr", "<cmd>IronRestart<cr>")
        -- vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
        -- vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
    end,
}
