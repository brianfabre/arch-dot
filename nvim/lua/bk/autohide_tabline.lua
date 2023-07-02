vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufDelete" }, {
	pattern = "*",
	callback = function()
		local buflist = vim.api.nvim_list_bufs()
		local count = 0
		for _, b in ipairs(buflist) do
			local islisted = vim.api.nvim_buf_get_option(b, "buflisted")
			if islisted then
				count = count + 1
			end
		end
		if count > 1 then
			vim.o.showtabline = 2
		else
			vim.o.showtabline = 0
		end
	end,
	group = vim.api.nvim_create_augroup("Tabline", { clear = true }),
})
