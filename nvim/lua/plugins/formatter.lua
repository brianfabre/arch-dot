local M = {

    {
        "mhartington/formatter.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local function cur_file()
                return vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
            end

            local prettier = function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", cur_file(), "--single-quote" },
                    stdin = true,
                }
            end

            local stylua = function()
                return {
                    exe = "stylua",
                    args = { "--config-path", "~/.config/nvim/stylua.toml", "-" },
                    stdin = true,
                }
            end

            local black = function()
                return {
                    exe = "black",
                    args = { "-" },
                    stdin = true,
                }
            end

            local latexindent = function()
                return {
                    exe = "latexindent",
                    args = { "" },
                    stdin = true,
                }
            end

            local styler = function()
                return {
                    exe = "R",
                    args = {
                        "--slave",
                        "--no-restore",
                        "--no-save",
                        "-e",
                        "'con <- file(\"stdin\"); styler::style_text(readLines(con)); close(con)'",
                        "2>/dev/null",
                    },
                    stdin = true,
                }
            end

            local function shfmt()
                return {
                    exe = "shfmt",
                    stdin = true,
                }
            end

            require("formatter").setup({
                -- logging = true,
                filetype = {
                    lua = { stylua },
                    python = { black },
                    r = { styler },
                    tex = { latexindent },
                    json = { prettier },
                    html = { prettier },
                    htmldjango = { prettier },
                    sh = { shfmt },
                    bash = { shfmt },
                    zsh = { shfmt },
                },
            })
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                pattern = "*",
                command = "silent FormatWrite",
                group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true }),
            })
        end,
    },
}

return M
