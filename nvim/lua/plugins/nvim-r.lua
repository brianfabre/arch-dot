return {
    "jalvesaq/Nvim-R",
    ft = {"r", "rmd"},
    config = function()
        vim.cmd([[
            let R_assign_map = '..'
            let g:R_auto_start = 2
            let R_csv_app = 'terminal:vd'
            let R_rconsole_height = winheight(0) / 3
            let R_rconsole_width = 0

            " use with radian
            let R_app = "radian"
            let R_cmd = "R"
            let R_hl_term = 0
            let R_args = []  " if you had set any
            let R_bracketed_paste = 1

            " au VimResized * let R_rconsole_height = winheight(0) / 3
            ]])
    end,
}
