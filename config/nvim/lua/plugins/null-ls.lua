local null_ls = require("null-ls")
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(clients)
            -- filter out clients that you don't want to use
            -- return vim.tbl_filter(function(client)
            --     return client.name ~= "tsserver"
            -- end, clients)
        end,
        bufnr = bufnr,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
            -- callback = vim.lsp.buf.format,
        })
    end
end

null_ls.setup({
    name = "Lua",
    filetypes = { "lua" },
    sources = {
        -- formatting.stylua,
    },
    on_attach = on_attach,
})

null_ls.setup({
    name = "HTML",
    filetypes = { "html" },
    sources = {
        -- formatting.djhtml,
    },
    on_attach = on_attach,
})

null_ls.setup({
    name = "Javascript/Typescript",
    filetypes = { "js", "ts", "vue" },
    sources = {
        code_actions.eslint_d,
        diagnostics.eslint_d,
        formatting.eslint_d,
    },
    on_attach = on_attach,
})

null_ls.setup({
    name = "SQL",
    filetypes = { "sql" },
    sources = {
        formatting.sqlformat,
    },
    on_attach = on_attach,
})

null_ls.setup({
    name = "python",
    filetypes = { "python" },
    sources = {
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
    },
    on_attach = on_attach,
})
