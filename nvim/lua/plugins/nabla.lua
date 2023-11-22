return {
    "jbyuki/nabla.nvim",
    event = "VeryLazy",
    ft = { "markdown" },
    config = function()
        vim.api.nvim_create_autocmd({ "Filetype" }, {
            pattern = { "markdown" },
            callback = function()
                local function map(mode, keys, func, desc)
                    if desc then
                        desc = "Nabla: " .. desc
                    end
                    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
                end
                map("n", "<leader>nt", function()
                    return require("nabla").toggle_virt()
                end, "[n]abla [t]oggle")
            end,
        })
    end,
}
