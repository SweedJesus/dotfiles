local util = require("util")
local map = util.map

local M = {}

local MAPPING_TOGGLE_TREE = "<Leader>n"
local MAPPING_TOGGLE_TREE_REVEAL = "<Leader>N"
local MAPPING_TOGGLE_BUFFERS = "<Leader>b"

local function _createToggle(name, mapping, cmd)
    local f = function(_) vim.cmd(cmd) end
    vim.api.nvim_create_user_command(name, f, {})
    map("n", mapping, string.format("<cmd>%s<cr>", cmd))
end

local function createToggleTree(cmd)
    _createToggle("ToggleTree", MAPPING_TOGGLE_TREE, cmd)
end

local function createToggleTreeReveal(cmd)
    _createToggle("ToggleTreeReveal", MAPPING_TOGGLE_TREE_REVEAL, cmd)
end

local function createToggleBuffers(cmd)
    _createToggle("ToggleBuffer", MAPPING_TOGGLE_BUFFERS, cmd)
end

M.neo_tree = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    local neo_tree = require("neo-tree")
    neo_tree.setup({
        -- close_if_last_window = true,
        window = {
            mappings = {
                ["<space>"] = { "toggle_node", nowait = true },
                ["o"] = { "toggle_node" },
            },
        },
        filesystem = {
            follow_current_file = {
                enabled = false,
                leave_dirs_open = false,
            },
        },
        buffers = {
            follow_current_file = {
                enabled = false,
                leave_dirs_open = false,
            },
        },
    })

    -- map("n", "<Leader>n", [[<cmd>Neotree toggle left<CR>]])
    -- map("n", "<Leader>N", [[<cmd>Neotree toggle reveal left<CR>]])
    -- map("n", "<Leader>b", [[<cmd>Neotree toggle buffers right<CR>]])

    createToggleTree("Neotree toggle left")
    createToggleTreeReveal("Neotree toggle reveal left")
    createToggleBuffers("Neotree toggle buffers right")
end

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
    nvim_tree.setup({
        select_prompts = true,
        -- icons = {
        -- }
        -- update_focused_file = {
        --     enable = true,
        --     update_cwd = false,
        --     ignore_list = {},
        -- },
    })

    -- map("n", "<Leader>n", [[<cmd>NvimTreeToggle<CR>]])
    -- map("n", "<Leader>N", [[<cmd>NvimTreeFindFileToggle<CR>]])

    createToggleTree("NvimTreeToggle")
    createToggleTreeReveal("NvimTreeFindFileToggle")
end

M.nerdtree = function()
end

return M
