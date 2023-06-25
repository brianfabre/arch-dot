local M = {

	{
		"dccsillag/magma-nvim",
		ft = "stata",
		dependencies = {
			"poliquin/stata-vim",
		},
		config = function()
			-- function
			local function close_float()
				-- removes any stuck floating window
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local config = vim.api.nvim_win_get_config(win)
					if config.relative ~= "" then
						vim.api.nvim_win_close(win, false)
						print("Closing window", win)
					end
				end
			end

			-- magma options
			vim.g.magma_automatically_open_output = false
			-- vim.g.magma_output_window_borders = false

			-- highlights for float
			-- moved to base16 config
			-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "", bg = "" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#112641" })

			local group = vim.api.nvim_create_augroup("statagroup", { clear = true })

			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = { "stata" },
				callback = function()
					vim.keymap.set("x", "<localleader>sd", ":<C-u>MagmaEvaluateVisual<CR>`>z<CR>", { silent = true })
				end,
				group = group,
			})

			vim.cmd([[
            autocmd FileType stata lua whichkeyStata()
            ]])

			_G.whichkeyStata = function()
				local wk = require("which-key")
				local buf = vim.api.nvim_get_current_buf()
				wk.register({
					["<localleader>"] = { name = "Magma" },
					["<localleader>i"] = { ":MagmaInit stata<CR>", "Initialize Magma" },
					["<localleader>d"] = { ":MagmaEvaluateLine<CR>", "Evaluate line" },
					-- visual mode doesnt work
					-- ["<localleader>v"] = { ":<C-u>MagmaEvaluateVisual<CR>`>z<CR>", "Evaluate visual" },
					["<localleader>r"] = { ":MagmaDelete<CR>", "Remove" },
					["<localleader>s"] = { ":MagmaShowOutput<CR>", "Show output" },
					["<localleader>e"] = { ":noautocmd MagmaEnterOutput<CR>", "Enter output" },
					["<localleader>c"] = { close_float, "Close float" },
				})
			end
		end,
	},
}

return M
