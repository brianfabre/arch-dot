return {
    "jackMort/ChatGPT.nvim",
    -- event = "VeryLazy",
    keys = { "<leader>sa" },
    cmd = "ChatGPT",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("chatgpt").setup()
        vim.keymap.set("n", "<leader>sa", ":ChatGPT<CR>", { desc = "chatGPT" })
    end,
}
