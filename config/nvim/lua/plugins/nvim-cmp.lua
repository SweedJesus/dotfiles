local luasnip = require('luasnip')
local cmp = require('cmp')

local lspkind = require('lspkind')
lspkind.init({
    with_text = true,
    preset = 'codicons',
    -- symbol_map = {
    --     Text = "t",
    --     Method = "m",
    --     Function = "f",
    --     Constructor = "c",
    --     Field = "f",
    --     Variable = "v",
    --     Class = "c",
    --     Interface = "i",
    --     Module = "m",
    --     Property = "p",
    --     Unit = "u",
    --     Value = "v",
    --     Enum = "e",
    --     Keyword = "k",
    --     Snippet = "s",
    --     Color = "c",
    --     File = "f",
    --     Reference = "r",
    --     Folder = "f",
    --     EnumMember = "e",
    --     Constant = "c",
    --     Struct = "s",
    --     Event = "e",
    --     Operator = "o",
    --     TypeParameter = "t"
    -- },
})

-- We're using LuaJIT which has 5.1 compatability
-- Prior to 5.2, upack was a global function
-- While 5.2 and beyond you use table.unpack
local unpack = unpack or table.unpack

local has_words_before = function()
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup{
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                -- cmp.complete()
                cmp.mapping.confirm({ select = true })
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
        {
            name = 'luasnip',
            options = { use_show_condition = true },
        },
        { name = 'nvim_lsp' },
        {
            -- https://github.com/hrsh7th/cmp-buffer
            name = 'buffer',
            keyword_length = 5,
            get_bufnrs = function()
                -- get visible buffer numbers
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
            end,
        },
        { name = 'path' },
    }, {
    }),
    experimental = {
        ghost_text = true,
    },
    formatting = {
        format = lspkind.cmp_format({
            -- with_text = false,
            -- maxwidth = 50,
            before = function(_, vim_item)
                return vim_item
            end,
        })
    },
}
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

