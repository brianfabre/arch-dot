local M = {

    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- A list of parser names, or "all"
            ensure_installed = { "python", "lua", "vim", "r", "bash" },
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "markdown", "latex" },
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-CR>",
                    node_incremental = "<C-CR>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<BS>",
                },
            },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}

return M
