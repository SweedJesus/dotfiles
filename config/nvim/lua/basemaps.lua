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
map('n', '<leader>w',  [[:w<cr>]])
map('n', '<leader>q',  [[:q<cr>]])
map('n', '<leader>Q',  [[:q!<cr>]])

-- Turn off highlighting
map('n', '<leader>l',  [[<cmd>nohl<cr>]])

-- Move between frames faster
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Re-edit last file
map('n', '<leader><space>', '<c-^>')

map('n', '<c-a-o>', [[:set bg=light<cr>]]);
map('n', '<c-a-p>', [[:set bg=dark<cr>]]);

-- Toggle mouse
-- map('n', '<F10>', '<cmd>lua ToggleMouse()<cr>')

-- Tab completion
--map("i", "<Tab>", "v:lua.tab_complete()", { noremap = false, expr = true })
--map("s", "<Tab>", "v:lua.tab_complete()", { noremap = false, expr = true })
--map("i", "<S-Tab>", "v:lua.s_tab_complete()", { noremap = false, expr = true })
--map("s", "<S-Tab>", "v:lua.s_tab_complete()", { noremap = false, expr = true })

-- Map compe confirm and complete functions
-- map('i', '<cr>', 'compe#confirm("<cr>")', { noremap = false, expr = true })
-- map('i', '<c-space>', 'compe#complete()', { noremap = false, expr = true })

-- Toggle file tree (NvimTree)
-- map('n', '<leader>n',  [[<cmd>NvimTreeToggle<cr>]])
-- (NERDTree)

-- Telescope
