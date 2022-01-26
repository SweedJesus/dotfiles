local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup{
    -- snippet = {
    --     expand = function(args)
    --         vim.fn['vsnip#anonymous'](args.body)
    --         -- require('luasnip').lsp_expand(args.body)
    --         -- vim.fn['UltiSnips#Anon'](args.body)
    --     end,
    -- },
    -- mapping = {
    --     ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    --     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    --     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    --     ['<C-y>'] = cmp.config.disable,
    --     ['<C-e>'] = cmp.mapping({
    --         i = cmp.mapping.abort(),
    --         c = cmp.mapping.close(),
    --     }),
    --     ['<CR>'] = cmp.mapping.confirm({select = true}),
    -- },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'luasnip' },
        { name = 'path' },
        -- { name = 'buffer', keyword_length = 5 },
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

