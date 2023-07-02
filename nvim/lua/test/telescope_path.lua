local function alert(body)
	require("notify")(body, "info", { title = "Test" })
end

-- local bufnr = vim.api.nvim_get_current_buf()
-- local pos = vim.api.nvim_win_get_cursor(0)
-- local servname = vim.api.nvim_get_vvar("servername")
-- local lc = vim.api.nvim_buf_line_count(bufnr)

-- alert(vim.inspect(pos))
-- alert(vim.inspect(servname))
-- name = Path:new(entry.filename):make_relative(dir)

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function get_path(prompt_bufnr)
	local prompt_bufnr = vim.api.nvim_get_current_buf()
	local picker = action_state.get_current_picker(prompt_bufnr)
	local entry = action_state.get_selected_entry(prompt_bufnr)

	-- -- absolute
	-- alert(vim.inspect(entry.path))
	-- -- relative
	-- alert(vim.inspect(entry.filename))

	actions.close(prompt_bufnr)

	local bufnr = vim.api.nvim_get_current_buf()
	local pos = vim.api.nvim_win_get_cursor(0)
	local row = pos[1] - 1
	local col = pos[2]

	local text = string.format("[](%s)", entry.filename)

	vim.api.nvim_buf_set_text(bufnr, row, col, row, col, { text })
	vim.cmd([[normal! lli]])
	-- local dir = vim.fn["vimwiki#vars#get_wikilocal"]("path")
	-- local dir = "~/Documents/wiki/"
	-- local dir = "/Users/brian/Documents/wiki"
	-- local doc_path = require("plenary.path"):new(dir, "*.*")
	-- alert(vim.inspect(dir))
end

path_link = function(prompt_bufnr)
	return get_path(prompt_bufnr)
end
