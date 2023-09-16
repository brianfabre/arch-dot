return {
    "jalvesaq/Nvim-R",
    ft = "r",
    config = function()
        vim.cmd([[
            let R_assign_map = '..'
            let g:R_auto_start = 2
            let R_csv_app = 'terminal:vd'
            " let R_set_omnifunc = []
            " let R_auto_omni = []
            let R_rconsole_height = winheight(0) / 3
            let R_rconsole_width = 0

            " au VimResized * let R_rconsole_height = winheight(0) / 3
            ]])
    end,
}
