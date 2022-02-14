local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda

local types = require("luasnip.util.types")

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {{"choiceNode", "Comment"}},
            },
        },
    },
    ext_base_prio = 300,
    ext_prio_increase = 1,
    enable_autosnippets = false,
})

ls.snippets = {
    all = {
    },
    python = {
    },
    rust = {
    },
    lua = {
        ls.parser.parse_snippet("expand", "-- hello"),
    },
}

-- vim.keymap.set({"i", "s"}, "<c-k>", function()
-- end, {silent = true})

-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/plugins/LuaSnip.lua<CR>")
