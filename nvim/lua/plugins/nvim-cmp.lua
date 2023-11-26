local M = {

    {
        "hrsh7th/nvim-cmp",
        event = { "BufReadPre", "BufNewFile" },
        -- event = "InsertEnter",
        keys = ":",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-omni",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            -- popup menu height
            vim.opt.pumheight = 20

            local kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }

            local t = function(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end

            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered({
                    --     border = "single",
                    --     col_offset = -1,
                    -- }),
                    documentation = cmp.config.window.bordered({
                        border = "single",
                    }),
                },
                formatting = {
                    format = function(entry, vim_item)
                        local prsnt, lspkind = pcall(require, "lspkind")
                        if not prsnt then
                            -- from kind_icons array
                            -- concatenates the icons with the name of the item kind
                            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                        else
                            -- From lspkind
                            return lspkind.cmp_format()
                        end
                        -- Source
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name]

                        vim_item.abbr = string.sub(vim_item.abbr, 1, 30)

                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    -- ["<C-e>"] = cmp.mapping.abort(),
                    -- ["<C-n>"] = cmp.mapping(function(fallback)
                    --     if luasnip.jumpable(1) then
                    --         luasnip.jump(1)
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s" }),
                    -- ["<C-p>"] = cmp.mapping(function(fallback)
                    --     if luasnip.jumpable(-1) then
                    --         luasnip.jump(-1)
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        -- cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        -- elseif has_words_before() then
                        --     cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            -- cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Down>"] = cmp.mapping(
                        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                        { "i" }
                    ),
                    ["<Up>"] = cmp.mapping(
                        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                        { "i" }
                    ),
                    ["<CR>"] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false }),
                    }),
                }),
                sources = cmp.config.sources({
                    {
                        name = "nvim_lsp",
                        entry_filter = function(entry)
                            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },
                    { name = "luasnip" },
                    { name = "omni" },
                    { name = "buffer" },
                    { name = "path" },
                }, {
                    -- { name = 'buffer' },
                    -- { name = "omni", trigger_characters = { "$" } },
                }),
                view = {
                    entries = { name = "custom", selection_order = "near_cursor" },
                },
                -- disables completion when cursor in comment
                enabled = function()
                    -- disable completion in comments
                    local context = require("cmp.config.context")
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                    end
                end,
            })

            cmp.setup.filetype("python", {
                sources = cmp.config.sources({
                    {
                        name = "nvim_lsp",
                        entry_filter = function(entry)
                            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

            -- -- disables completion in markdown
            -- local autocmd = vim.api.nvim_create_autocmd
            -- autocmd("FileType", {
            --     -- pattern = { "sh" },
            --     pattern = {},
            --     callback = function()
            --         require("cmp").setup.buffer({ enabled = false })
            --     end,
            -- })

            -- cmdline setup.
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
        end,
    },
}

return M
