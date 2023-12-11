return {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>lg", "<cmd>LazyGitCurrentFile<cr>", { desc = "lazygit" })
        vim.g.lazygit_floating_window_use_plenary = 1
    end,
}
