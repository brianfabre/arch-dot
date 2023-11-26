return {
    "ibhagwan/fzf-lua",
    event = { "BufReadPre", "BufNewFile" },
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            winopts = {
                -- Use **only one** of the below options
                -- split = "aboveleft new"   -- open in split above current window
                -- split = "belowright new", -- open in split below current window
                -- split = "aboveleft vnew"  -- open in split left of current window
                -- split = "belowright vnew", -- open in split right of current window
                -- split = "topleft new", -- open in a full-width split on top
                split = "botright new", -- open in a full-width split on the bottom
                -- split = "topleft vnew"  -- open in a full-height split on the far left
                -- split = "botright vnew", -- open in a full-height split on the far right
                border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }, -- thin straight
                -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            },
        })
        vim.keymap.set(
            "n",
            "<leader>ff",
            "<cmd>lua require('fzf-lua').files()<CR>",
            { silent = true, desc = "search files" }
        )
        vim.keymap.set(
            "n",
            "<leader>ss",
            "<cmd>lua require('fzf-lua').buffers()<CR>",
            { silent = true, desc = "search open buffer" }
        )
        vim.keymap.set(
            "n",
            "<leader>sb",
            "<cmd>lua require('fzf-lua').blines()<CR>",
            { silent = true, desc = "search buffer lines" }
        )
        vim.keymap.set(
            "n",
            "<leader>sr",
            "<cmd>lua require('fzf-lua').oldfiles()<CR>",
            { silent = true, desc = "search recent files" }
        )
        vim.keymap.set(
            "n",
            "<leader>sg",
            "<cmd>lua require('fzf-lua').live_grep()<CR>",
            { silent = true, desc = "live grep" }
        )
        vim.keymap.set(
            "n",
            "<leader>sc",
            "<cmd>lua require('fzf-lua').command_history()<CR>",
            { silent = true, desc = "search command history" }
        )
        vim.keymap.set(
            "n",
            "<leader>sh",
            "<cmd>lua require('fzf-lua').highlights()<CR>",
            { silent = true, desc = "search highlights" }
        )
    end,
}
