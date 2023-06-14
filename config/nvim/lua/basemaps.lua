-- Set key mappings

local util = require('util')
local map = util.map
local map_buf = util.map_buf

-- Remap space as leader key
-- map('n', '<Space>', '', {})
map('', '<Space>', '<Nop>')
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Y yank until the end of line
map('n', 'Y', 'y$')

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Write/close edit
map('n', '<leader>w', [[:w<CR>]])
map('n', '<leader>q', [[:q<CR>]])
map('n', '<leader>Q', [[:q!<CR>]])

-- Turn off highlighting
map('n', '<leader>l', [[<CMD>nohl<CR>]])

-- Move between frames faster
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Re-edit last file
map('n', '<leader><space>', '<c-^>')

map('n', '<c-a-o>', [[:set bg=light<CR>]]);
map('n', '<c-a-p>', [[:set bg=dark<CR>]]);

-- Toggle mouse
-- map('n', '<F10>', '<CMD>lua ToggleMouse()<CR>')

-- Reduce tab
map('n', '<S-Tab>', [[<<]])
map('i', '<S-Tab>', [[<C-d>]])

-- Diagnostics
map("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>")
map("n", "[D", "<CMD>lua vim.diagnostic.goto_prev()<CR>")
map("n", "]D", "<CMD>lua vim.diagnostic.goto_next()<CR>")
map("n", "[d", "<CMD>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>")
map("n", "]d", "<CMD>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>")

-- Toggle paragraph autoformatting
local function toggleParagraphAutoFormat()
    if not vim.o.fo:find("a") then
        print("auto format ON")
        vim.opt.fo:append("a")
    else
        print("auto format OFF")
        vim.opt.fo:remove("a")
    end
end

map("n", "<C-p>", toggleParagraphAutoFormat)

-- Map compe confirm and complete functions
-- map('i', '<CR>', 'compe#confirm("<CR>")', { noremap = false, expr = true })
-- map('i', '<c-space>', 'compe#complete()', { noremap = false, expr = true })

-- Toggle file tree (NvimTree)
-- map('n', '<leader>n',  [[<CMD>NvimTreeToggle<CR>]])
-- (NERDTree)

-- Telescope
