return {
    "L3MON4D3/LuaSnip",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    build = "make install_jsregexp",
    init = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    end,
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
