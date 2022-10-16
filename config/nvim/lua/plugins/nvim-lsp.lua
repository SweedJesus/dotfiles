local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')
-- local lsp_installer_servers = require('nvim-lsp-installer.servers')

-- -------------------------------------------------------------------------------------------------
-- common
-- -------------------------------------------------------------------------------------------------

local disable_formatting_for = {
    -- "jsonls",
    "volar",
    "tsserver",
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local timeout_ms = 2000

local function format(bufnr)
    vim.lsp.buf.format({
        filter = function(clients)
            return vim.tbl_filter(
                function(client)
                    if type(client) ~= "table" then
                        return false
                    end
                    return not vim.tbl_contains(disable_formatting_for, client.name)
                end,
                clients
            )
        end,
        bufnr = bufnr,
        timeout_ms = timeout_ms,
    })
end

local function setup_formatting(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                format(bufnr)
            end,
        })
    end
end

-- -------------------------------------------------------------------------------------------------
-- lsp_installer and lspconfig
-- -------------------------------------------------------------------------------------------------

local hover = {
    -- border = "none",
    -- border = "single",
    -- border = "double",
    border = "rounded",
    -- border = "solid",
    -- border = "shadow",
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, hover)

-- Sumneko lua
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

-- Simple, nothing special to setup servers
local servers = {
    graphql = {},
    -- html = {},
    sqlls = {},
    -- quick_lint_js = {},
    jsonls = {
        init_options = {
            provideFormatter = false,
        },
    },
    cssls = {},
    tsserver = {},
    volar = {
        filetypes = {
            'typescript',
            'javascript',
            'javascriptreact',
            'typescriptreact',
            'vue',
            'json',
        },
    },
    rust_analyzer = {},
    pyright = {
    },
    prismals = {
        prisma = {
            editor = {
                tabSize = 2,
            },
        },
    },
    sumneko_lua = {
        opts = {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = lua_runtime_path,
                    },
                    diagnostics = { globals = { 'vim', 'feedkey' } },
                    workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                    telemetry = { enable = false },
                }
            }
        }
    },
}

local lsp_on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    setup_formatting(client, bufnr)
    vim.api.nvim_create_user_command("Format", function(buf) format(buf.buf) end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local default_opts = {
    on_attach = lsp_on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
}

-- Install and setup language servers
--
-- "Deprecation of lsp_installer.on_server_ready()"
-- https://github.com/williamboman/nvim-lsp-installer/discussions/636
lsp_installer.setup {}
for server_name, server_conf in pairs(servers) do
    local opts = vim.tbl_extend('keep', server_conf.opts or {}, default_opts)
    lspconfig[server_name].setup(opts)
    -- local server_available, server = lsp_installer_servers.get_server(server_name)
    -- if server_available then
    --     server:on_ready(function()
    --         local opts = vim.tbl_extend('keep', server_conf.opts or {}, default_opts)
    --         server:setup(opts)
    --         server:attach_buffers()
    --     end)
    --     if not server:is_installed() then
    --         server:install()
    --     end
    -- end
end

-- -------------------------------------------------------------------------------------------------
-- null_ls
-- -------------------------------------------------------------------------------------------------

local null_ls = require("null-ls")

null_ls.setup({
    debug = true,
    debounce_text_changes = 150,
    sources = {
        -- Basic HTML/CSS/JS
        -- # TODO: only include when not Vue
        null_ls.builtins.formatting.djhtml.with({
            filetypes = { "d", "html", "htmldjango" },
            extra_args = { "-t", "2" },
        }),
        -- TS, Vue
        -- null_ls.builtins.code_actions.eslint,
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.formatting.eslint,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.eslint_d,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.prettierd,
        -- SQL
        null_ls.builtins.formatting.sqlformat,
        -- Python
        null_ls.builtins.diagnostics.pylama.with({
            -- for some reason pylama wants to start at the repository root?
            -- this means it'll miss a pylama.ini in a nested directory
            -- e.g. project/python/pylama.ini
            cwd = vim.loop.cwd,
        }),
        null_ls.builtins.formatting.black.with({
            cwd = vim.loop.cwd,
        }),
        null_ls.builtins.formatting.isort.with({
            cwd = vim.loop.cwd,
        }),
    },
    on_attach = function(client, bufnr)
        setup_formatting(client, bufnr)
    end,
})
