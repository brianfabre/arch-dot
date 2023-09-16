local M = {
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
                        height = 0.7,
                        width = 0.7,
                        preview_width = 0.6,
                        -- mirror = true,
                        -- prompt_position = "top",
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
}

return M
