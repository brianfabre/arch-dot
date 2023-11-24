return {
    "stevearc/oil.nvim",
    keys = {
        {

            "_",
            "<cmd>Oil<cr>",
            desc = "open file explorer",
        },
    },
    cmd = "Oil",
    -- opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            keymaps = {
                -- ["g?"] = "actions.show_help",
                -- ["<CR>"] = "actions.select",
                -- ["<C-s>"] = "actions.select_vsplit",
                -- ["<C-h>"] = "actions.select_split",
                -- ["<C-t>"] = "actions.select_tab",
                -- ["<C-p>"] = "actions.preview",
                ["q"] = "actions.close",
                -- ["<C-l>"] = "actions.refresh",
                ["<BS>"] = "actions.parent",
                -- ["_"] = "actions.open_cwd",
                -- ["`"] = "actions.cd",
                -- ["~"] = "actions.tcd",
                -- ["gs"] = "actions.change_sort",
                -- ["g."] = "actions.toggle_hidden",
            },
            buf_options = {
                buflisted = false,
                bufhidden = "hide",
            },
            view_options = {
                show_hidden = true,
            },
        })
    end,
}
