local lspkind = require('lspkind')
local cmp = require('cmp')

local H = {
    not_selected = function()
        return vim.fn.complete_info()["selected"] == -1
    end,
    can_expand = function()
        return vim.fn["UltiSnips#CanExpandSnippet"]() == 1
    end,
    expand = function()
        feedkey("<C-R>=UltiSnips#ExpandSnippet()<CR>")
    end,
    can_jump_forward = function()
        return vim.fn["UltiSnips#CanJumpForwards"]() == 1
    end,
    jump_forward = function()
        feedkey("<ESC>:call UltiSnips#JumpForwards()<CR>")
    end,
    has_words_before = function(char)
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
            return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        if not char then
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        else
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col) == char
        end
    end,
}

cmp.setup{
    snippet = {
        expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
        end,
    },
    mapping = {
    --     ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    --     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    --     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    --     ['<C-y>'] = cmp.config.disable,
    --     ['<C-e>'] = cmp.mapping({
    --         i = cmp.mapping.abort(),
    --         c = cmp.mapping.close(),
    --     }),
    --     ['<CR>'] = cmp.mapping.confirm({select = true}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if H.not_selected() and H.can_expand() then
                H.expand()
            elseif H.can_jump_forward() then
                H.jump_forward()
            elseif H.has_words_before() then
                cmp.confirm({ select = true })
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    sources = cmp.config.sources({
        -- { name = 'luasnip' },
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

