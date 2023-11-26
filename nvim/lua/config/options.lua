-- options
-- stylua: ignore start
-- vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- vim.g.loaded_netrw = 1                                   -- disable netrw
-- vim.g.loaded_netrwPlugin = 1                             -- disable netrw
vim.g.netrw_winsize = 20                               -- netrw options
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.mouse = 'a'
vim.opt.scrolloff = 4                                    -- leaves space when scrolling
vim.opt.hlsearch = false
vim.opt.incsearch = true                                 -- search as characters are entered
vim.opt.tabstop = 4                                      -- sets tab spacing
vim.opt.shiftwidth = 4                                   -- sets tab spacing
vim.opt.expandtab = true                                 -- sets tab spacing
vim.opt.autoindent = true
vim.opt.ignorecase = true                                -- case-insensitive search
vim.opt.smartcase = true                                 -- case-insensitive search
vim.opt.linebreak = true                                 -- doesnt split words
vim.opt.breakindent = true                               -- enable indentation
vim.opt.breakindentopt = { 'shift:4', 'sbr', 'list:-1' } -- indent by an additional 4 characters on wrapped line
vim.opt.showbreak = '>'                                  -- append '>>' to indent
vim.opt.completeopt = { 'noselect' }
vim.opt.foldmethod = 'marker'
vim.opt.laststatus = 3                                   -- global status
vim.opt.updatetime = 300

-- ## not in use ##
-- vim.opt.cmdheight = 0
vim.opt.cursorline = true
-- vim.opt.laststatus = 0                                   -- hides status line
-- vim.formatoptions = 'tqj'                                -- removed 'c'
-- stylua: ignore end
