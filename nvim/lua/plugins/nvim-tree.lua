local M = {

	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		-- keys = { "<leader>v" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- disable netrw at the very start of your init.lua (strongly advised)
			vim.g.loaded = 1
			vim.g.loaded_netrwPlugin = 1

			local win_height = vim.api.nvim_win_get_height(0)
			local win_width = vim.api.nvim_win_get_width(0)
			local float_height = math.floor(math.min(70, win_height * 0.7))
			local float_width = math.floor(math.min(90, win_width * 0.7))
			local float_row = math.floor((vim.api.nvim_win_get_height(0) - float_height) / 2)
			local float_col = math.floor((vim.api.nvim_win_get_width(0) - float_width) / 2)

			-- empty setup using defaults
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				reload_on_bufenter = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				view = {
					centralize_selection = true,
				},
				renderer = {
					icons = {
						show = {
							git = false,
						},
					},
				},
				git = {
					ignore = false,
				},
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
				-- view = {
				-- 	float = {
				-- 		enable = true,
				-- 		-- enable = false,
				-- 		quit_on_focus_loss = true,
				-- 		open_win_config = {
				-- 			relative = "editor",
				-- 			border = "rounded",
				-- 			width = float_width,
				-- 			height = float_height,
				-- 			row = float_row,
				-- 			col = float_col,
				-- 		},
				-- 	},
				-- },
			})
			vim.api.nvim_set_keymap("n", "<leader>v", ":NvimTreeToggle<cr>", {
				desc = "Toggle NvimTree",
				noremap = true,
				silent = true,
			})
		end,
	},
}

return M
