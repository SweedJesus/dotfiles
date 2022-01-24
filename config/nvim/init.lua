-- nilsso neovim Lua configuration lua

local util = require('util')
local opts = util.opts();

-- =================================================================================================
-- Options
-- =================================================================================================

-- Indents/tabs
opts.autoindent = true
opts.smartindent = true    -- Insert indents automatically
opts.expandtab = true      -- Use spaces instead of tabs
opts.shiftwidth = 4        -- Size of an indent
opts.tabstop = 4           -- Number of spaces tabs count for
opts.softtabstop = 4
opts.shiftround = true     -- Round indent
opts.joinspaces = false    -- No double spaces with join after a dot
opts.breakindent = true    --Enable break indent

--Enable mouse mode
opts.mouse = "a"

-- Graphical font
vim.cmd([[set guifont=FiraCode\ Nerd\ Font:h11]])

-- Column wrap
vim.cmd([[set tw=100]])
vim.cmd([[set cc=+1]])

opts.termguicolors = true

--Set highlight on search
opts.hlsearch = true
opts.incsearch = true

--Make line numbers default
opts.number = true

--Do not save when switching buffers
opts.hidden = true

--Save undo history
vim.cmd([[set undofile]])

--Case insensitive searching UNLESS /C or capital in search
opts.ignorecase = true
opts.smartcase = true

-- Decrease update time
opts.updatetime = 250
opts.signcolumn="yes"

-- Remap escape to leave terminal mode
-- vim.api.nvim_exec([[
vim.cmd [[
augroup Terminal autocmd! au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n> au TermOpen * set nonu augroup end
]]
--]], false)

-- Return to last edit position when opening files
vim.api.nvim_exec([[ autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]], false)

-- Add map to enter paste mode
opts.pastetoggle="<F3>"
-- opts.pastetoggle="<leader>p" -- I don't know how to set this yet

-- Map blankline
vim.g.indent_blankline_char = "⋮"
-- vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
    if opts.mouse == 'a' then
        vim.cmd([[IndentBlanklineDisable]])
        opts.signcolumn='no'
        opts.mouse = 'v'
        opts.number = false
        print("Mouse disabled")
    else
        vim.cmd([[IndentBlanklineEnable]])
        opts.signcolumn='yes'
        opts.mouse = 'a'
        opts.number = true
        print("Mouse enabled")
    end
end

-- Change preview window location
vim.g.splitbelow = true

-- Highlight on yank
vim.api.nvim_exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]], false)

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

vim.g.html_indent_script1 = "inc"
vim.g.html_indent_style1 = "inc"
vim.g.html_indent_inctags = "html,body,head,tbody"

vim.cmd [[
augroup Indentation
    autocmd!
    autocmd FileType javascript set shiftwidth=2
    autocmd FileType typescript set shiftwidth=2
    autocmd FileType vue set shiftwidth=2
    autocmd FileType html set shiftwidth=2
augroup END
]]

require('plugins')
require('maps')
