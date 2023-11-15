local M = {
    {
        "preservim/vim-markdown",
        ft = {
            "vimwiki",
            "markdown",
        },
        -- all vimwiki-related dependencies here
        -- must load vimwiki first
        dependencies = {
            "godlygeek/tabular",
        },
        config = function()
            -- vim.cmd("setlocal syntax=markdown")
            vim.g.markdown_fenced_languages = { "python=python", "r=r" }
            vim.g.vim_markdown_autowrite = 1 -- auto-saves when entering link
            vim.g.vim_markdown_folding_disabled = 1
            -- vim.g.vim_markdown_folding_level = 2
            vim.g.vim_markdown_frontmatter = 1 -- highlights yaml frontmatter
            vim.g.vim_markdown_toc_autofit = 1
            vim.g.vim_markdown_new_list_item_indent = 0 -- no indent when pressing typing 'o'
        end,
    },
    {
        "michal-h21/vim-zettel",
        ft = {
            "vimwiki",
            "markdown",
        },
        config = function()
            vim.cmd([[
            let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
            let g:zettel_format = '%Y%m%d%H%M%S'
            let g:zettel_options = [{"disable_front_matter": 1, "template" :  "~/Documents/wiki/template.tpl"}]
            let g:vimwiki_markdown_link_ext = 1
            ]])
        end,
    },
    {
        "mzlogin/vim-markdown-toc",
        ft = {
            "vimwiki",
            "markdown",
        },
        config = function()
            vim.cmd([[
            let g:vmt_fence_text = 'TOC'
            let g:vmt_fence_closing_text = '/TOC'
            ]])
        end,
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
}

return M
