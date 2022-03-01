local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')

-- Sumneko lua
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

-- Simple, nothing special to setup servers
local servers = {
    graphql = {},
    html = {},
    -- quick_lint_js = {},
    rust_analyzer = {},
    pylsp = {
    --     -- # NOTE: with nvim-lint we don't need per-venv pylsp installation, here is fine
    --     -- but linting plugins go in nvim-lint.lua instead of here.
        opts = {
            settings = {
                pylsp = {
                    plugins = {
                        yapf = { enabled = true },
                        pyls_isort = { enabled = true },
    --                     flake8 = { enabled = false },
                        -- pylsp_black = { enabled = true },
    --                     pycodestyle = { enabled = false },
                    }
                }
            }
        }
    },
    sumneko_lua = {
        opts = {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = lua_runtime_path,
                    },
                    diagnostics = { globals = {'vim', 'feedkey'} },
                    workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                    telemetry = { enable = false },
                }
            }
        }
    },
}

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    -- buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
        augroup LSP_FORMAT
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 5000)
        augroup END
        ]])
    end

    -- require("lsp_signature").on_attach({
		-- bind = true,
		-- hint_prefix = "🧸 ",
		-- handler_opts = { border = "rounded" },
	-- }, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local default_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 200,
    },
}

-- Install and setup language servers
for server_name, server_conf in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available then
        server:on_ready(function()
            local opts = vim.tbl_extend('keep', server_conf.opts or {}, default_opts)
            server:setup(opts)
            server:attach_buffers()
        end)
        if not server:is_installed() then
            server:install()
        end
    end
end

-- require('rust-tools').setup({})
-- lsp_installer.on_server_ready(function(server)
--     local opts = vim.tbl_extend('keep', {}, default_opts)
--     if server.name == "rust_analyzer" then
--         require "rust-tools".setup {
--             server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
--         }
--         server:attach_buffers()
--     else
--         server:setup(opts)
--     end
-- end)

-- NOTE: this is old at not needed with nvim-lint
-- install pynvim and python-lsp-server[all] to py3nvim
--
-- https://github.com/python-lsp/python-lsp-server#installation
-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
-- https://github.com/jdhao/nvim-config/blob/master/lua/config/lsp.lua
-- lspconfig.pylsp.setup(vim.tbl_extend('keep', default_setup_table, {
--     settings = {
--         pylsp = {
--             plugins = {
--                 -- -- Default
--                 -- rope_completion = { enabled = false },
--                 -- pyflakes = { enabled = false },
--                 -- mccabe = { enabled = false },
--                 -- pycodestyle = { enabled = false },
--                 -- pydocstyle = { enabled = false },
--                 -- autopep8 = { enabled = false },
--                 -- yapf = { enabled = false },
--                 -- -- 3rd party
--                 -- flake8 = { enabled = false },
--                 -- pylsp_mypy = { enabled = false },
--                 -- pyls_isort = { enabled = false },
--                 -- python_lsp_black = { enabled = false },
--                 -- pyls_memestra = { enabled = false },
--                 -- pylsp_rope = { enabled = false },
--                 -- -- *th party
--                 -- pylint = {
--                 --     enabled = false,
--                 -- --     -- executable = "pylint",
--                 -- --     -- args = {  -- NOTE: was this for mypy?
--                 -- --     --     '--extension_pkg_whitelist',
--                 -- --     --     'pydantic',
--                 -- --     -- },
--                 -- },
--             },
--         },
--     },
-- }))

