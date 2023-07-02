local M = {
    "L3MON4D3/LuaSnip",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    opts = {
        history = true,
        delete_check_events = "TextChanged",
    },
    config = function()
        require("luasnip.loaders.from_lua").load({
            paths = vim.fn["stdpath"]("config") .. "/luasnippets/",
        })
    end,
}

return M
