local function alert(body)
    require("notify")(body, "info", { title = "Test" })
end

local bufnr = vim.api.nvim_get_current_buf()
local pos = vim.api.nvim_win_get_cursor(0) -- 0 for cur window
-- vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] + 1 })
local wins = vim.api.nvim_list_wins()

-- local asdf = vim.api.nvim_get_current_line()
-- vim.api.nvim_set_current_line("asdf")
-- vim.api.nvim_set_current_buf(26)

-- Define the file path
local file_path = vim.fn.expand("~/Desktop/asdf.txt")

-- Read the contents of the file
local lines = vim.api.nvim_call_function("readfile", { file_path })

-- Print the contents of the file
-- for _, line in ipairs(lines) do
--     print(line)
-- end
-- OR
-- Concatenate lines into a string
local file_contents = table.concat(lines, "\n")
alert(file_contents)

-- alert(vim.inspect(wins))
-- alert(vim.inspect(bufnr))
-- alert(vim.inspect(pos))
-- alert(vim.inspect(asdf))

-- local function write()
--     print("hello")
--     -- vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { "hello", "check" })
-- end
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     group = vim.api.nvim_create_augroup("asdf", { clear = true }),
--     pattern = "test.lua",
--     callback = function()
--         vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { "hello", "check" })
--     end,
-- })
