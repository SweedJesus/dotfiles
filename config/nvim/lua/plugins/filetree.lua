local util = require('util')
local map = util.map

local M = {}

M.nvim_tree = function()
    local nvim_tree = require('nvim-tree')
    nvim_tree.setup{}

    map('n', '<Leader>n', [[<cmd>NvimTreeToggle<CR>]])
end

M.nerdtree = function()
end

return M
