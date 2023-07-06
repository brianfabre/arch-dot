local M = {

    {
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
    },
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
            let g:zettel_options = [{"disable_front_matter": 1, "template" :  "/Volumes/Bob/wiki/template.tpl"}]
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
            vim.g.vmt_fence_text = "TOC"
            vim.g.vmt_fence_closing_text = "/TOC"
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            mappings = { extra = false },
        },
        config = function(_, opts)
            require("Comment").setup(opts)
            vim.keymap.set("n", "<leader>/", ":normal gcc<cr>", { desc = "toggle comment line" })
            vim.keymap.set(
                "v",
                "<leader>/",
                "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
                { desc = "toggle comment selection" }
            )
        end,
    },
    -- {
    --     "jiangmiao/auto-pairs",
    --     event = "VeryLazy",
    --     config = function()
    --         vim.g.AutoPairsShortcutFastWrap = "<c-e>"
    --     end,
    -- },
    {
        "jalvesaq/Nvim-R",
        ft = "r",
        config = function()
            vim.cmd([[
            let R_assign_map = '..'
            let g:R_auto_start = 2
            let R_csv_app = 'terminal:vd'
            " let R_set_omnifunc = []
            let R_auto_omni = []
            let R_rconsole_height = winheight(0) / 3
            let R_rconsole_width = 0

            " au VimResized * let R_rconsole_height = winheight(0) / 3
            ]])
        end,
    },
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.g.vimtex_quickfix_mode = 0
            vim.cmd([[let g:vimtex_view_method = 'zathura']])
            vim.cmd([[
                let g:vimtex_compiler_latexmk_engines = {
                \ '_'                : '-pdf',
                \ 'pdfdvi'           : '-pdfdvi',
                \ 'pdfps'            : '-pdfps',
                \ 'pdflatex'         : '-pdf',
                \ 'luatex'           : '-lualatex',
                \ 'lualatex'         : '-lualatex',
                \ 'xelatex'          : '-xelatex',
                \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
                \ 'context (luatex)' : '-pdf -pdflatex=context',
                \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
                \}
            ]])
            -- vim.cmd([[
            --     let g:vimtex_compiler_latexmk = {
            --     \ 'executable' : 'latexmk',
            --     \ 'options' : [
            --     \   '-lualatex',
            --     \   '-file-line-error',
            --     \   '-synctex=1',
            --     \   '-interaction=nonstopmode',
            --     \ ],
            --     \}
            -- ]])
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- char = "▏",
            char = "│",
            filetype_exclude = { "help", "alpha", "markdown", "neo-tree", "lazy" },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
            filter = {
                fzf = {
                    extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
                },
            },
            preview = {
                auto_preview = true,
            },
        },
    },
    {
        "chentoast/marks.nvim",
        keys = "m",
        config = function()
            require("marks").setup({
                mappings = {
                    preview = false,
                    delete_buf = "mda",
                    next = "mw",
                    prev = "mq",
                },
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        -- enabled = false,
        opts = {
            stages = "static",
            timeout = 2000,
            render = "minimal",
        },
    },
}

return M
