local util = require("util")
local map = util.map

local M = {}

M.nvim_tree = function()
    local devicons = require("nvim-web-devicons")
    devicons.set_icon {
        -- md = {
        --     icon = "",
        --     color = "#519aba",
        --     name = "Md",
        -- },
        ["poetry.lock"] = {
            icon = "",
            color = "#706d67",
            name = "Lock",
        },
        [".pylintrc"] = {
            icon = "",
            color = "#aaa28a",
            name = "Pylint",
        },
        xlsx = {
            icon = "",
            color = "#35af2a",
            name = "Excel",
        },
    }

    local nvim_tree = require("nvim-tree")
    nvim_tree.setup{
        -- icons = {
        -- }
        update_focused_file = {
            enable = true,
            update_cwd = false,
            ignore_list = {},
        },
    }

    map("n", "<Leader>n", [[<cmd>NvimTreeToggle<CR>]])
end

M.nerdtree = function()
end

return M
