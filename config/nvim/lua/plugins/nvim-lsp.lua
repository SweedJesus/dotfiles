local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')
-- local diagnostic = require('vim.diagnostic')
-- local lsp_installer_servers = require('nvim-lsp-installer.servers')

-- -------------------------------------------------------------------------------------------------
-- common
-- -------------------------------------------------------------------------------------------------

-- vim.diagnostic.config({
--     -- virtual_text = {
--     --     -- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
--     -- },
--     float = {
--         -- https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.open_float()
--         -- TODO: figure out how to show the actual code of the diagnostic
--         source = true,
--     },
-- })

-- -------------------------------------------------------------------------------------------------
-- lsp_installer and lspconfig
-- -------------------------------------------------------------------------------------------------

local hover = {
    -- border = "none",
    border = "single",
    -- border = "double",
    -- border = "rounded",
    -- border = "solid",
    -- border = "shadow",
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, hover)

-- Sumneko lua
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

local servers = {
    graphql = {},
    html = {
        opts = {
            filetypes = {
                'd',
                'html',
                'htmldjango',
            },
            init_options = {
                -- provideFormatter = false,
            },
            settings = {
                -- https://code.visualstudio.com/Docs/languages/html#_formatting
                html = {
                    format = {
                        wrapLineLength = 100,
                        -- unformatted = {},
                        -- contentUnformatted = {
                        --     'style',
                        -- },
                        wrapAttributes = 'auto',
                        -- wrapAttributes = 'force',
                        -- wrapAttributes = 'force-aligned',
                        -- wrapAttributes = 'force-expand-multiline',
                        -- wrapAttributes = 'aligned-multiple',
                        -- wrapAttributes = 'preserve',
                        -- wrapAttributes = 'preserve-aligned',
                        templating = true,
                        unformattedContentDelimiter = '{# nofmt #}',
                    },
                },
            },
        },
    },
    sqlls = {},
    -- quick_lint_js = {},
    jsonls = {
        opts = {
            init_options = {
                provideFormatter = false,
            },
        },
    },
    cssls = {},
    -- tsserver = {},
    volar = {
        opts = {
            filetypes = {
                'typescript',
                'javascript',
                'javascriptreact',
                'typescriptreact',
                'vue',
                'json',
            },
        },
    },
    rust_analyzer = {},
    pyright = {},
    ruff_lsp = {
        -- format on save? code actions?
        -- https://github.com/charliermarsh/ruff-lsp/issues/95
    },
    prismals = {
        opts = {
            prisma = {
                editor = {
                    tabSize = 2,
                },
            },
        },
    },
    lua_ls = {
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

local skip_formatting_for = {
    -- "jsonls",
    "volar",
    "vue-language-server",
    "tsserver",
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- local timeout_ms = 2000

local function format(bufnr)
    vim.lsp.buf.format({
        async = true,
        bufnr = bufnr,
        -- timeout_ms = timeout_ms,
        filter = function(client)
            -- see <https://neovim.io/doc/user/lsp.html#lsp-buf> {vim.lsp.buf.format}
            local skip = vim.tbl_contains(skip_formatting_for, client.name)
            -- print('client', client.name, 'skip', skip)
            return not skip
        end,
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

local disable_hover_for = {
    "ruff-lsp"
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
    buf_set_keymap("n", "gS", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    vim.api.nvim_create_user_command("Format", function(buf) format(buf.buf) end, {})

    setup_formatting(client, bufnr)

    if vim.tbl_contains(disable_hover_for, client.name) then
        client.server_capabilities.hoverProvider = false
    end
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
mason.setup()
mason_lspconfig.setup()
for server_name, server_conf in pairs(servers) do
    -- local opts = server_conf.opts or {}
    local opts = vim.tbl_extend('keep', server_conf.opts or {}, default_opts)
    -- print(server_name, vim.inspect(opts))
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
        -- null_ls.builtins.formatting.djhtml.with({
        --     filetypes = { "d", "html", "htmldjango" },
        --     extra_args = { "-t", "2" },
        -- }),
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
        -- null_ls.builtins.diagnostics.ruff,
        -- null_ls.builtins.formatting.ruff,
        -- null_ls.builtins.diagnostics.pylama.with({
        --     -- for some reason pylama wants to start at the repository root?
        --     -- this means it'll miss a pylama.ini in a nested directory
        --     -- e.g. project/python/pylama.ini
        --     cwd = vim.loop.cwd,
        -- }),
        null_ls.builtins.formatting.black.with({
            cwd = vim.loop.cwd,
        }),
        -- null_ls.builtins.formatting.isort.with({
        --     cwd = vim.loop.cwd,
        -- }),
    },
    on_attach = function(client, bufnr)
        setup_formatting(client, bufnr)
    end,
})
