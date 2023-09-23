return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
    config = function()
        local Rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")

        require("nvim-autopairs").setup({
            ignored_next_char = "", -- autopair even before char
            fast_wrap = {
                map = "<C-e>",
                end_key = "'",
                manual_position = false,
            },
        })

        local cond = require("nvim-autopairs.conds")
        print(vim.inspect(cond))

        npairs.add_rules({
            Rule("$", "$", { "tex", "latex" })
                -- don't add a pair if the next character is %
                :with_pair(cond.not_after_regex("%%"))
                -- don't add a pair if  the previous character is xxx
                :with_pair(
                    cond.not_before_regex("xxx", 3)
                )
                -- don't move right when repeat character
                :with_move(cond.none())
                -- don't delete if the next character is xx
                :with_del(cond.not_after_regex("xx"))
                -- disable adding a newline when you press <cr>
                :with_cr(cond.none()),
        })

        npairs.add_rule(Rule("$$", "$$", "tex"))
    end,
}
