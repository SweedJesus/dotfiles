-- nilsso neovim Lua configuration lua

local util = require('util')
local util_opts = util.opts();

-- =================================================================================================
-- Options
-- =================================================================================================

-- Indents/tabs
util_opts.autoindent = true
util_opts.smartindent = true -- Insert indents automatically
util_opts.expandtab = true -- Use spaces instead of tabs
util_opts.shiftwidth = 4 -- Size of an indent
util_opts.tabstop = 4 -- Number of spaces tabs count for
util_opts.softtabstop = 4
util_opts.shiftround = true -- Round indent
util_opts.joinspaces = false -- No double spaces with join after a dot
util_opts.breakindent = true --Enable break indent

-- Python virtual environments
-- TODO: automate the setup with rcrc
-- https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments
vim.g.python_host_prog = '$HOME/.pyenv/versions/nvim2/bin/python'
vim.g.python3_host_prog = '$HOME/.pyenv/versions/nvim3/bin/python'

-- Window separator color
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.api.nvim_set_hl(0, 'WinSeparator', {
            fg = vim.g.terminal_color_0,
        })
        vim.api.nvim_set_hl(0, 'Folded', {
            fg = vim.g.terminal_color_3,
        })
        vim.api.nvim_set_hl(0, 'FoldColumn', {
            fg = vim.g.terminal_color_0,
        })
    end,
})


-- Display chars
vim.opt.list = true
vim.opt.fillchars = {
    eob = "–",
    fold = " ",
    vert = "│",
    -- vert = "v",
    foldsep = " ",
    foldclose = "",
    foldopen = ""
}
-- vim.opt.listchars = vim.opt.listchars + {
--     tab = "··",
--     lead = " ",
--     eol = "﬋"
-- }

--Enable mouse mode
util_opts.mouse = "a"

-- Graphical font
-- vim.cmd([[set guifont=FiraCode\ Nerd\ Font:h11]])

-- Column wrap (global)
vim.cmd([[set tw=100]])
vim.cmd([[set cc=+1]])

util_opts.termguicolors = true

--Set highlight on search
util_opts.hlsearch = true
util_opts.incsearch = true

--Make line numbers default
util_opts.number = true

--Do not save when switching buffers
util_opts.hidden = true

--Save undo history
vim.cmd([[set undofile]])

--Case insensitive searching UNLESS /C or capital in search
util_opts.ignorecase = true
util_opts.smartcase = true

-- Decrease update time
util_opts.updatetime = 250
util_opts.signcolumn = "yes"

-- Remap escape to leave terminal mode
-- vim.api.nvim_exec([[
vim.cmd [[
augroup Terminal
autocmd!
autocmd TermOpen * tnoremap <buffer> <Esc> <c-\><c-n> au TermOpen * set nonu
augroup end
]]
--]], false)

-- Return to last edit position when opening files
vim.api.nvim_exec([[ autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
    , false)

-- Add map to enter paste mode
util_opts.pastetoggle = "<F3>"
-- opts.pastetoggle="<leader>p" -- I don't know how to set this yet

-- Map blankline
-- vim.g.indent_blankline_char = "⋮"
-- vim.g.indent_blankline_char = "│"
-- vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
-- vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
-- vim.g.indent_blankline_char_highlight = 'LineNr'

-- Toggle to disable mouse mode and indentlines for easier paste
-- ToggleMouse = function()
--     if opts.mouse == 'a' then
--         vim.cmd([[IndentBlanklineDisable]])
--         opts.signcolumn='no'
--         opts.mouse = 'v'
--         opts.number = false
--         print("Mouse disabled")
--     else
--         vim.cmd([[IndentBlanklineEnable]])
--         opts.signcolumn='yes'
--         opts.mouse = 'a'
--         opts.number = true
--         print("Mouse enabled")
--     end
-- end

-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
vim.api.nvim_exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]], false)

vim.diagnostic.config({
    float = {
        source = "always",
        -- border = border,
    },
})

-- Python
-- vim.api.nvim_exec([[
-- augroup PythonConfig
--     autocmd!
--     autocmd FileType python set tw=80
-- augroup end
-- ]], false)

-- Map :Format to vim.lsp.buf.formatting()
-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

-- vim.g.html_indent_script1 = "inc"
-- vim.g.html_indent_style1 = "inc"
-- vim.g.html_indent_inctags = "html,body,head,tbody"

-- TODO: move these down into vim.filetype.add below
vim.cmd [[
augroup Indentation
    autocmd!
    autocmd FileType css set shiftwidth=2
    autocmd FileType json set shiftwidth=2
    autocmd FileType javascript set shiftwidth=2
    autocmd FileType typescript set shiftwidth=2
    autocmd FileType vue set shiftwidth=2
    autocmd FileType html set shiftwidth=2
    autocmd FileType htmldjango set shiftwidth=2
    autocmd FileType markdown set shiftwidth=2
    autocmd FileType python set tw=90
augroup END
]]

vim.cmd("let g:do_filetype_lua = 1")

vim.filetype.add({
    -- extension = {
    --     jinja = function()
    --         print("A")
    --     end,
    -- },
    -- filename = {
    --     ["html.jinja"] = function()
    --         util_opts.filetype = "htmldjango"
    --         util_opts.shiftwidth = 2
    --     end,
    -- },
    pattern = {
        [".*html%.jinja"] = function()
            util_opts.filetype = "htmldjango"
            util_opts.shiftwidth = 2
            util_opts.commentstring = "{#%s#}"
        end,
    },
})

require('basemaps')
require('plugins')
