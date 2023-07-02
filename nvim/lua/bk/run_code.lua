local function run_code()
    local buf_list = vim.api.nvim_list_bufs()
    local pattern = "^term://"
    for _, bufnr in ipairs(buf_list) do
        local pathname = vim.api.nvim_buf_get_name(bufnr)
        local isterm = pathname:find(pattern) ~= nil
        if isterm then
            vim.api.nvim_buf_delete(bufnr, { force = true })
        end
    end

    local curbufpath = vim.api.nvim_buf_get_name(0)
    local curbufnr = vim.api.nvim_get_current_win()
    local height = math.floor(vim.api.nvim_win_get_height(0) / 3.5)

    vim.api.nvim_command("write")
    vim.api.nvim_command(string.format("%s split|ter python3 %s", height, curbufpath))
    vim.api.nvim_set_current_win(curbufnr)
end

-- vim.keymap.set("n", "<leader>ip", run_code, {})

local group = vim.api.nvim_create_augroup("codegroup", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "python" },
    callback = function()
        vim.keymap.set("n", "<leader>pp", run_code, { silent = true })
    end,
    group = group,
})
