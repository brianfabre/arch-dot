local M = {

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local status_ok, alpha = pcall(require, "alpha")
            if not status_ok then
                return
            end

            local header = require("alpha.themes.theta").config.layout[2]
            local recent = require("alpha.themes.theta").config.layout[4]
            local dashboard = require("alpha.themes.dashboard")
            local links = {
                type = "group",
                val = {
                    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                    { type = "padding", val = 1 },
                    dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                    -- dashboard.button("s", " " .. " Search directory", ":Telescope live_grep <CR>"),
                    -- dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>"),
                    dashboard.button("f", " " .. " Search files", ":lua require('fzf-lua').files() <CR>"),
                    dashboard.button("s", " " .. " Live grep", ":lua require('fzf-lua').live_grep() <CR>"),
                    dashboard.button("i", " " .. " Config", ":e $MYVIMRC <CR> :cd %:p:h <CR>"),
                    dashboard.button("w", " " .. " Wiki", ":WikiIndex <CR> :cd %:p:h <CR>"),
                    dashboard.button("q", " " .. " Quit", ":qa<CR>"),
                },
                position = "center",
            }

            local plugins = tostring(require("lazy").stats().count)

            local config = {
                layout = {
                    { type = "padding", val = 2 },
                    header,
                    { type = "padding", val = 2 },
                    subheader,
                    { type = "padding", val = 2 },
                    links,
                    { type = "padding", val = 2 },
                    recent,
                    { type = "padding", val = 2 },
                    {
                        type = "text",
                        -- val = "Plugins: " .. plugins,
                        val = "Placeholder for lazyvimstarted",
                        opts = { hl = "SpecialComment", position = "center" },
                    },
                },
                opts = {
                    noautocmd = false,
                    redraw_on_resize = true,
                },
            }

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            alpha.setup(config)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    config.layout[#config.layout].val = "⚡ Neovim loaded"
                        -- .. stats.count
                        -- .. " plugins in "
                        .. " in "
                        .. ms
                        .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })

            vim.api.nvim_set_keymap(
                "n",
                "<leader>a",
                ":Alpha<cr>",
                { desc = "start menu", noremap = true, silent = true }
            )
        end,
    },
}

return M
