return {
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
}
