local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
    sources = {
        -- Lua
        -- formatting.stylua,
        -- Javascript
        diagnostics.eslint,
        formatting.eslint_d,
        -- "HTML"
        -- formatting.djhtml,
        -- Python
        diagnostics.pylama,
        -- formatting.yapf,
        formatting.black,
        formatting.isort,
        -- Spelling
        -- completion.spell,
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
        end
    end,
})
