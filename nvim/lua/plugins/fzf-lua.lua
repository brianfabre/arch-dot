return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            winopts = {},
        })
        vim.keymap.set(
            "n",
            "<leader>ff",
            "<cmd>lua require('fzf-lua').files()<CR>",
            { silent = true, desc = "search files" }
        )
        vim.keymap.set(
            "n",
            "<leader>sb",
            "<cmd>lua require('fzf-lua').blines()<CR>",
            { silent = true, desc = "search buffer lines" }
        )
        vim.keymap.set(
            "n",
            "<leader>so",
            "<cmd>lua require('fzf-lua').oldfiles()<CR>",
            { silent = true, desc = "search old files" }
        )
        vim.keymap.set(
            "n",
            "<leader>sg",
            "<cmd>lua require('fzf-lua').live_grep()<CR>",
            { silent = true, desc = "live grep" }
        )
        vim.keymap.set(
            "n",
            "<leader>sh",
            "<cmd>lua require('fzf-lua').command_history()<CR>",
            { silent = true, desc = "search command history" }
        )
    end,
}
