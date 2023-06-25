local function alert(body)
    require("notify")(body, "info", { title = "Test" })
end

local bufnr = vim.api.nvim_get_current_buf()
-- local pos = vim.api.nvim_win_get_cursor(0)
-- local servname = vim.api.nvim_get_vvar("servername")
-- local lc = vim.api.nvim_buf_line_count(bufnr)
--
alert(vim.inspect(bufnr))

-- local asdf = require("lazy").stats()
--
-- alert(vim.inspect(asdf.loaded))
