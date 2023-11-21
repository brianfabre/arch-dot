return {
    {
        "lervag/wiki.vim",
        dependencies = {
            "godlygeek/tabular",
            { "preservim/vim-markdown", branch = "master" },
        },
        init = function()
            vim.cmd([[
                let g:wiki_link_creation = {
                  \ 'md': { 'url_transform': { _ -> strftime('%Y%m%d%H%M%S') },
                  \ },
                  \}
                let g:wiki_templates = [
                  \ { 'match_func': {x -> v:true},
                  \   'source_filename': '~/Documents/wiki/template.tpl'},
                  \]
            ]])
        end,
        config = function()
            -- lervag/wiki.vim
            vim.g.wiki_root = "~/Documents/wiki"

            -- preservim/vim-markdown
            vim.opt.conceallevel = 2
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_new_list_item_indent = 0 -- no indent when pressing 'o'
            vim.g.vim_markdown_frontmatter = 1 -- highlights yaml frontmatter

            -- -- WIP changes tag parsing regex
            -- vim.g.wiki_tag_scan_num_lines = -1
            -- vim.cmd([[
            --     let g:wiki_tag_parsers = [
            --     \ g:wiki#tags#default_parser,
            --     \ { 'match': {x -> x =~# '^tags: '},
            --     \   'parse': {x -> split(matchstr(x, '^tags:\zs\[[^][ ]*\]'), '[ ,]\+')},
            --     \   'make':  {t, x -> 'tags: ' . empty(t) ? '' : join(t, ', ')}}
            --     \]
            -- ]])
        end,
    },
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {},
        config = function()
            vim.cmd([[highlight Headline1 guibg=#2C6E00 guifg=#58DB01 gui=italic]])
            vim.cmd([[highlight Headline2 guibg=#C8DB01 guifg=#2C6E00 gui=italic]])
            vim.cmd([[highlight CodeBlock guibg=#07230E guifg=lightyellow]])
            vim.cmd([[highlight Quote guifg=#0099EC]])

            require("headlines").setup({
                markdown = {
                    headline_highlights = {
                        "Headline1",
                        "Headline2",
                    },
                    fat_headlines = false,
                    fat_headline_upper_string = "▃",
                    codeblock_highlight = "CodeBlock",
                    quote_highlight = "Quote",
                    -- quote_string = "┃",
                    quote_string = ">> ",
                    dash_highlight = "Dash",
                    dash_string = "_",
                },
            })
        end,
    },
    -- {
    --     "vimwiki/vimwiki",
    --     cmd = "VimwikiIndex",
    --     keys = "<space>ww",
    --     -- event = "VeryLazy",
    --     -- must initialize before load plugin
    --     init = function()
    --         vim.g.vimwiki_list = {
    --             {
    --                 path = "/home/brian/Documents/wiki/",
    --                 syntax = "markdown",
    --                 ext = ".md",
    --                 diary_rel_path = "journal/",
    --                 diary_index = "journal",
    --                 diary_header = "Journal",
    --             },
    --         }
    --         vim.g.vimwiki_global_ext = 0
    --         vim.g.vimwiki_hl_headers = 1
    --         vim.g.vimwiki_auto_chdir = 1
    --         vim.g.vimwiki_key_mappings = { table_mappings = 0 }
    --     end,
    --     config = function()
    --         vim.cmd([[
    --         autocmd FileType vimwiki nnoremap <CR> <cmd>silent VimwikiFollowLink<cr>
    --         " complete file path for external files
    --         inoremap <expr> <c-f> fzf#vim#complete#path('rg --files --no-ignore-vcs')
    --         ]])
    --     end,
    -- },
    -- {
    --     "michal-h21/vim-zettel",
    --     ft = {
    --         "vimwiki",
    --         "markdown",
    --     },
    --     config = function()
    --         vim.cmd([[
    --         let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
    --         let g:zettel_format = '%Y%m%d%H%M%S'
    --         let g:zettel_options = [{"disable_front_matter": 1, "template" :  "~/Documents/wiki/template.tpl"}]
    --         let g:vimwiki_markdown_link_ext = 1
    --         ]])
    --     end,
    -- },
    -- {
    --     "mzlogin/vim-markdown-toc",
    --     ft = {
    --         "vimwiki",
    --         "markdown",
    --     },
    --     config = function()
    --         vim.cmd([[
    --         let g:vmt_fence_text = 'TOC'
    --         let g:vmt_fence_closing_text = '/TOC'
    --         ]])
    --     end,
    -- },
}
