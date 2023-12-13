local M = {

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "seblj/nvim-echo-diagnostics",
            { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
        },
        config = function()
            -- test start
            local border = {
                { "🭽", "FloatBorder" },
                { "▔", "FloatBorder" },
                { "🭾", "FloatBorder" },
                { "▕", "FloatBorder" },
                { "🭿", "FloatBorder" },
                { "▁", "FloatBorder" },
                { "🭼", "FloatBorder" },
                { "▏", "FloatBorder" },
            }

            -- LSP settings (for overriding per client)
            local handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
            }

            -- Do not forget to use the on_attach function
            -- require("lspconfig").myserver.setup({ handlers = handlers })
            -- test end

            require("echo-diagnostics").setup({
                show_diagnostic_number = true,
                show_diagnostic_source = false,
            })
            -- show line diagnostics automatically in hover window or echo
            vim.diagnostic.config({ virtual_text = false })
            vim.o.updatetime = 250
            vim.cmd([[autocmd CursorHold * lua require('echo-diagnostics').echo_line_diagnostic()]])

            -- icons
            vim.fn.sign_define("DiagnosticSignError", {
                texthl = "DiagnosticSignError",
                text = "",
                numhl = "DiagnosticSignError",
            })

            vim.fn.sign_define("DiagnosticSignWarn", {
                texthl = "DiagnosticSignWarn",
                text = "",
                numhl = "DiagnosticSignWarn",
            })
            vim.fn.sign_define("DiagnosticSignHint", {
                texthl = "DiagnosticSignHint",
                text = "",
                numhl = "DiagnosticSignHint",
            })
            vim.fn.sign_define("DiagnosticSignInfo", {
                texthl = "DiagnosticSignInfo",
                text = "",
                numhl = "DiagnosticSignInfo",
            })

            -- Mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            -- local opts = { noremap = true, silent = true }
            -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
            -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end

                nmap("<leader>lr", vim.lsp.buf.rename, "[r]ename")
                -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                nmap("<space>ld", vim.lsp.buf.definition, "goto [d]efinition")
                nmap("<space>lk", vim.lsp.buf.hover, "hover documentation")
                nmap("<space>lc", vim.lsp.buf.code_action, "[c]ode action")
                -- vim.keymap.set("<space>co", vim.diagnostic.open_float, bufopts)
                -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                -- vim.keymap.set('n', '<space>wl', function()
                --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                -- end, bufopts)
                -- vim.keymap.set("n", "<space>gd", vim.lsp.buf.type_definition, bufopts)
                -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
            end

            -- must call neodev before lspconfig
            require("neodev").setup({})

            -- Set up lspconfig.
            require("lspconfig")["lua_ls"].setup({
                on_attach = on_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                settings = {
                    Lua = {
                        format = {
                            enable = false,
                        },
                        completion = { callSnippet = "Replace" },
                        runtime = { version = "LuaJIT" },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            require("lspconfig")["bashls"].setup({
                on_attach = on_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            require("lspconfig").clangd.setup({
                cmd = { "clangd" },
                filetypes = { "c", "cpp" },
                on_attach = on_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            require("lspconfig").rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            -- enable = false,
                        },
                    },
                },
            })

            require("lspconfig")["pyright"].setup({
                handlers = handlers,
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            -- autoSearchPaths = true,
                            -- useLibraryCodeForTypes = true,
                            diagnosticMode = "openFilesOnly",
                        },
                    },
                },
            })
            -- require("lspconfig").jedi_language_server.setup({})

            -- vscode comp theme
            vim.cmd([[
            " gray
            highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
            " blue
            highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
            highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
            " light blue
            highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
            highlight! link CmpItemKindInterface CmpItemKindVariable
            highlight! link CmpItemKindText CmpItemKindVariable
            " pink
            highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
            highlight! link CmpItemKindMethod CmpItemKindFunction
            " front
            highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
            highlight! link CmpItemKindProperty CmpItemKindKeyword
            highlight! link CmpItemKindUnit CmpItemKindKeyword
            ]])
        end,
    },
}

return M
