local lspconfig = require('lspconfig')
local lsp_installer_servers = require('nvim-lsp-installer.servers')

-- Sumneko lua
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

local servers = {
    graphql = {},
    html = {},
    jedi_language_server = {},
    sumneko_lua = {
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
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function on_attach(client, bufnr)
    local opts = { noremap = true, silent = true }
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gl", "<cmd>lua require('user.plugins.custom.lspconfig').show_line_diagnostics()<CR>", opts)
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
end

local default_setup_table = {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
    flags = {
        debounce_text_changes = 500,
    },
}

-- Install and setup language servers
for server_name, specific_setup_table in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available and not server:is_installed() then
        server:install()
    end
    local setup_table = vim.tbl_extend('keep', specific_setup_table, default_setup_table)
    lspconfig[server_name].setup(setup_table)
end

