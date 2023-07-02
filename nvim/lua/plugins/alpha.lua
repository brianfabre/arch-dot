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

            local function return_todo()
                local path = "/Volumes/MacAsahi/Documents/wiki/index.md"
                -- todo's are between begstring and finstring
                local begstring = "important dates"
                local finstring = "wip"
                local todos = {}
                local start = false
                for line in io.lines(path) do
                    -- local endmatch = string.find(line, finstring)
                    -- local startmatch = string.find(line, begstring)
                    local endmatch = line:find(finstring)
                    local startmatch = line:find(begstring)
                    if endmatch then
                        break
                    end
                    if start then
                        -- %] = the last instance of ]
                        -- (.*) = match and capture 0+ characters
                        local str = line:match("%](.*)")

                        -- removes trailing spaces in beg + end
                        str = string.gsub(str, "^%s*(.-)%s*$", "%1")

                        -- adds string to position 1
                        -- str = str:gsub("()", { [1] = " " })
                        str = str:gsub("()", { [1] = " " })

                        todos[#todos + 1] = str
                    end
                    if startmatch then
                        start = true
                    end
                end
                return todos
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
                    dashboard.button("s", " " .. " Search directory", ":Telescope live_grep <CR>"),
                    dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>"),
                    dashboard.button("i", " " .. " Config", ":e $MYVIMRC <CR> :cd %:p:h <CR>"),
                    -- dashboard.button("w", " " .. " Wiki", ":e /Volumes/Bob/wiki/index.md <CR>"),
                    dashboard.button("w", " " .. " Wiki", ":VimwikiIndex <CR>"),
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
                    config.layout[#config.layout].val = "⚡ Neovim loaded "
                        .. stats.count
                        .. " plugins in "
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
