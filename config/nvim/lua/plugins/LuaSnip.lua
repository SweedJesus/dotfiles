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
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

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

local H = "html"
local M = "markdown"
-- local P = "python"

local snippet_groups = {
    {
        {H,M}, {
            s(
                "tag",
                fmt("<{}{}>{}</{}>", {
                    i(1),
                    i(2),
                    i(3),
                    rep(1),
                })
            )
        }
    }
}

for _, pair in pairs(snippet_groups) do
    local langs = pair[1]
    local snippets = pair[2]
    for _, lang in pairs(langs) do
        for _, snippet in pairs(snippets) do
            ls.snippets[lang] = ls.snippets[lang] or {}
            table.insert(ls.snippets[lang], snippet)
        end
    end
    -- ls.snippets[lang] = {}
end

-- ls.snippets = {
--     all = {},
--     python = {},
--     rust = {},
--     lua = {},
-- }

-- vim.keymap.set({"i", "s"}, "<c-k>", function()
-- end, {silent = true})

-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/plugins/LuaSnip.lua<CR>")
vim.keymap.set("n", "<leader>ls", "<cmd>source ~/.config/nvim/lua/plugins/LuaSnip.lua<CR>")
