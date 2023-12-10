-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

return {

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

    {
        "nvim-telescope/telescope.nvim",
        event = { "BufReadPre", "BufNewFile" },
        version = false, -- telescope did only one release, so use HEAD for now
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local borderchars = {
                prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            }
            local borderchars_dropdown = {
                prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            }

            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "%.csv", "%.txt", "%.xml" },
                    prompt_prefix = "   ",
                    -- layout_strategy = "vertical",
                    -- layout_config = {
                    --     height = 0.95,
                    --     width = 0.95,
                    --     -- preview_height = 0.5,
                    --     mirror = true,
                    --     prompt_position = "top",
                    -- },
                    layout_strategy = "horizontal",
                    layout_config = {
                        height = 0.6,
                        width = 0.6,
                    },
                    mappings = {
                        i = {
                            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                            ["<esc>"] = actions.close,
                            ["<C-o>"] = path_link,
                        },
                        n = {
                            -- ["<C-o>"] = function(prompt_bufnr) end,
                            ["<C-o>"] = path_link,
                        },
                    },
                    -- layout_config = {
                    --     horizontal = {
                    --         height = 0.8,
                    --         width = 0.8,
                    --         preview_width = 0.5,
                    --     },
                    -- },
                    preview = {
                        -- hide_on_startup = true, -- hide previewer when picker starts
                    },
                    borderchars = borderchars,
                    -- ripgrep_arguments = {
                    -- 	"rg",
                    -- 	"--hidden",
                    -- 	"--no-heading",
                    -- 	"--with-filename",
                    -- 	"--line-number",
                    -- 	"--column",
                    -- 	"--smart-case",
                    -- },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    project = {
                        theme = "dropdown",
                        order_by = "recent",
                        -- sync_with_nvim_tree = true, -- default false
                    },
                },
            })

            require("telescope").load_extension("fzf")

            -- mappings
            local ts = {
                builtin = require("telescope.builtin"),
                grep_fuzzy = function()
                    require("telescope.builtin").grep_string({
                        prompt_title = "FZF",
                        shorten_path = true,
                        word_match = "-w",
                        only_sort_text = true,
                        use_regex = true,
                        search = "",
                    })
                end,
            }

            local dropdown = require("telescope.themes").get_dropdown({
                borderchars = borderchars_dropdown,
                previewer = false,
                layout_config = { width = 0.4 },
                -- prompt_title = false,
            })

            local themes = require("telescope.themes")

            vim.keymap.set("n", "<leader>ff", function()
                ts.builtin.find_files(dropdown)
            end, { desc = "files" })
            vim.keymap.set("n", "<leader>sc", function()
                ts.builtin.command_history(dropdown)
            end, { desc = "command history" })
            vim.keymap.set("n", "<leader>sv", function()
                -- ts.builtin.buffers(dropdown)
                ts.builtin.buffers()
            end, { desc = "buffers" })
            vim.keymap.set("n", "<leader>sg", ts.grep_fuzzy, { desc = "grep" })
            -- vim.keymap.set("n", "<leader>sg", function()
            --     ts.builtin.grep_string(dropdown_grep)
            -- end, { desc = "grep" })
            vim.keymap.set("n", "<leader>sb", ts.builtin.current_buffer_fuzzy_find, { desc = "buffer" })
            vim.keymap.set("n", "<leader>sh", ts.builtin.help_tags, { desc = "help tags" })
            vim.keymap.set("n", "<leader>sm", ts.builtin.marks, { desc = "marks" })
            vim.keymap.set("n", "<leader>sl", ts.builtin.highlights, { desc = "highlights" })
            vim.keymap.set("n", "<leader>ss", ts.builtin.colorscheme, { desc = "colorscheme" })
        end,
    },

    {
        "ahmedkhalf/project.nvim",
        opts = {
            -- Methods of detecting the root directory. **"lsp"** uses the native neovim
            -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
            -- order matters: if one is not detected, the other is used as fallback. You
            -- can also delete or rearangne the detection methods.
            detection_methods = { "lsp", "pattern" },

            -- All the patterns used to detect root dir, when **"pattern"** is in
            -- detection_methods
            patterns = { "main.tex", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

            -- Don't calculate root dir on specific directories
            -- Ex: { "~/.cargo/*", ... }
            exclude_dirs = {},

            -- Show hidden files in telescope
            show_hidden = false,
        },
        event = "VeryLazy",
        config = function(_, opts)
            require("project_nvim").setup(opts)
            require("telescope").load_extension("projects")
        end,
        keys = {
            { "<leader>sp", "<Cmd>Telescope projects<CR>", desc = "projects" },
        },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>v",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
                use_libuv_file_watcher = true,
            },
            window = {
                width = 25,
                mappings = {
                    ["<space>"] = "none",
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                symbols = {
                    -- Change type
                    added = "✚",
                    deleted = "✖",
                    modified = "",
                    renamed = "",
                    -- Status type
                    untracked = "",
                    ignored = "",
                    unstaged = "",
                    staged = "",
                    conflict = "",
                },
            },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },

    {
        "nvim-pack/nvim-spectre",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("spectre").setup()

            -- vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").open()<CR>', {
            --     desc = "Open Spectre",
            -- })
            -- vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
            --     desc = "Search current word",
            -- })
            -- vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
            --     desc = "Search current word",
            -- })
            vim.keymap.set("n", "<leader>rf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
                desc = "Search on current file",
            })
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup({
                scope = {
                    show_start = false,
                    show_end = false,
                },
                whitespace = {
                    remove_blankline_trail = true,
                },
                exclude = {
                    filetypes = {
                        "help",
                        "alpha",
                        "markdown",
                        "vimwiki",
                        "neo-tree",
                        "lazy",
                    },
                },
            })
        end,
    },

    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function()
            local rt = require("rust-tools")

            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        vim.keymap.set("n", "<Leader>pp", rt.runnables.runnables, { buffer = bufnr })
                    end,
                },
                tools = {
                    inlay_hints = {
                        auto = false,
                    },
                },
            })
        end,
    },

    {
        "xiyaowong/nvim-transparent",
        opts = {
            extra_groups = {
                "Folded",
                "TelescopeNormal",
                "NormalFloat",
                "StatusLine",
                "StatusLineNC",
            },
        },
    },

    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
            filetypes_denylist = {
                "markdown",
                "vimwiki",
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
        },
    },
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
}
