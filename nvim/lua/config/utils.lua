local util = {}

function util.FindAll()
    local p = vim.fn.input("Search: ")
    vim.fn.execute('vimgrep "' .. p .. '" %')
    vim.fn.execute("copen")
end

function util.SearchReplace()
    local search = vim.fn.input("Find: ")
    local replace = vim.fn.input("Replace with: ")
    vim.fn.execute("%s/" .. search .. "/" .. replace .. "/gc")
end

function util.RunCode()
    local buf_list = vim.api.nvim_list_bufs()
    local pattern = "^term://"
    for _, bufnr in ipairs(buf_list) do
        local pathname = vim.api.nvim_buf_get_name(bufnr)
        local isterm = pathname:find(pattern) ~= nil
        if isterm then
            vim.api.nvim_buf_delete(bufnr, { force = true })
        end
    end

    local curbufpath = vim.api.nvim_buf_get_name(0)
    local curbufnr = vim.api.nvim_get_current_win()
    local height = math.floor(vim.api.nvim_win_get_height(0) / 3.5)

    vim.api.nvim_command("write")
    vim.api.nvim_command(string.format("%s split|ter python3 %s", height, curbufpath))
    vim.api.nvim_set_current_win(curbufnr)
end

local terminals = {}
-- Opens a floating terminal (interactive by default)
function util.float_term(cmd, opts)
    opts = vim.tbl_deep_extend("force", {
        ft = "lazyterm",
        size = { width = 0.9, height = 0.9 },
    }, opts or {}, { persistent = true })

    local termkey = vim.inspect({ cmd = cmd or "shell", cwd = opts.cwd, env = opts.env, count = vim.v.count1 })

    if terminals[termkey] and terminals[termkey]:buf_valid() then
        terminals[termkey]:toggle()
    else
        terminals[termkey] = require("lazy.util").float_term(cmd, opts)
        local buf = terminals[termkey].buf
        vim.b[buf].lazyterm_cmd = cmd
        if opts.esc_esc == false then
            vim.keymap.set("t", "<esc>", "<esc>", { buffer = buf, nowait = true })
        end
        if opts.ctrl_hjkl == false then
            vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = buf, nowait = true })
            vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = buf, nowait = true })
            vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = buf, nowait = true })
            vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = buf, nowait = true })
        end

        -- not unmapping affects lazygit
        vim.cmd("tunmap jk")

        vim.api.nvim_create_autocmd("BufEnter", {
            buffer = buf,
            callback = function()
                vim.cmd.startinsert()
            end,
        })
    end

    return terminals[termkey]
end

function util.get_root()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                    and vim.tbl_map(function(ws)
                        return vim.uri_to_fname(ws.uri)
                    end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

return util
