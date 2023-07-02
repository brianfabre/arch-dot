local M = {
    {

        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            -- local group = vim.api.nvim_create_augroup("statagroup", { clear = true })
            --
            -- vim.api.nvim_create_autocmd({ "FileType" }, {
            -- 	pattern = { "stata" },
            -- 	callback = function()
            -- 		vim.keymap.set("x", "<localleader>sd", ":<C-u>MagmaEvaluateVisual<CR>`>z<CR>", { silent = true })
            -- 	end,
            -- 	group = group,
            -- })

            vim.cmd([[
            autocmd FileType markdown lua whichkeyMarkdown()

            function OpenMarkdownPreview (url)
              execute "silent ! open -a Firefox -n --args --new-window " . a:url
            endfunction
            let g:mkdp_browserfunc = 'OpenMarkdownPreview'

            ]])

            vim.g.mkdp_theme = "dark" -- disable netrw

            _G.whichkeyMarkdown = function()
                local wk = require("which-key")
                local buf = vim.api.nvim_get_current_buf()
                wk.register({
                    ["<localleader>ll"] = { ":MarkdownPreviewToggle<CR>", "Toggle preview" },
                })
            end
        end,
    },
}

return M
