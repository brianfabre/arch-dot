return {
    "vimwiki/vimwiki",
    cmd = "VimwikiIndex",
    keys = "<space>ww",
    -- event = "VeryLazy",
    -- must initialize before load plugin
    init = function()
        vim.g.vimwiki_list = {
            {
                path = "/home/brian/Documents/wiki/",
                syntax = "markdown",
                ext = ".md",
                diary_rel_path = "journal/",
                diary_index = "journal",
                diary_header = "Journal",
            },
        }
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_hl_headers = 1
        vim.g.vimwiki_auto_chdir = 1
        vim.g.vimwiki_key_mappings = { table_mappings = 0 }
    end,
    config = function()
        vim.cmd([[
            autocmd FileType vimwiki nnoremap <CR> <cmd>silent VimwikiFollowLink<cr>
            " complete file path for external files
            inoremap <expr> <c-f> fzf#vim#complete#path('rg --files --no-ignore-vcs')
            ]])
    end,
}
