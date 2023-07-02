local function alert(body)
    require("notify")(body, "info", { title = "Test" })
end

-- local bufnr = vim.api.nvim_get_current_buf()
local bufnr = 8
local pos = vim.api.nvim_win_get_cursor(0)

local function write()
    print("hello")
    -- vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { "hello", "check" })
end

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("asdf", { clear = true }),
    pattern = "test.lua",
    callback = function()
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { "hello", "check" })
    end,
})

alert(vim.inspect(bufnr))
alert(vim.inspect(pos))
