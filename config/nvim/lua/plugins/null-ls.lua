local null_ls = require("null-ls")
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

-- require("nvim.lua.plugins.null-ls.pylama")
-- local pylama = require("plugins.null-ls.pylama")

null_ls.setup({
    sources = {
        -- Lua
        -- formatting.stylua,
        -- Javascript
        code_actions.eslint_d,
        diagnostics.eslint_d,
        formatting.eslint_d,
        -- formatting.prettierd,
        -- "HTML"
        -- formatting.djhtml,
        -- Python
        diagnostics.pylama.with({
            -- NOTE: for some reason pylama wants to start at the repository root?
            -- this means it'll miss a pylama.ini in a nested directory
            -- e.g. project/python/pylama.ini
            cwd = vim.loop.cwd,
        }),
        formatting.black.with({
            cwd = vim.loop.cwd,
        }),
        formatting.isort.with({
            cwd = vim.loop.cwd,
        }),
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
