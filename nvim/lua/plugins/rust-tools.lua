return {
    "simrat39/rust-tools.nvim",
    config = function()
        local rt = require("rust-tools")

        rt.setup({
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<Leader>pp", rt.runnables.runnables, { buffer = bufnr })
                end,
            },
            tools = {
                inlay_hints = {
                    auto = false,
                },
            },
        })
    end,
}
