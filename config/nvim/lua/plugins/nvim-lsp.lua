-- We're using LuaJIT which has 5.1 compatability
-- Prior to 5.2, upack was a global function
-- While 5.2 and beyond you use table.unpack
local unpack = unpack or table.unpack

local lspconfig = require('lspconfig')
local lsp_installer_servers = require('nvim-lsp-installer.servers')

local servers = {
    { "graphql" },
    { "html" },
    { "jedi_language_server" },
    {
        "sumneko_lua",
        function()
            local lua_runtime_path = vim.split(package.path, ';')
            table.insert(lua_runtime_path, 'lua/?.lua')
            table.insert(lua_runtime_path, 'lua/?/init.lua')
            return {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = lua_runtime_path,
                        },
                        diagnostics = { globals = {'vim', 'feedkey'} },
                        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                        telemetry = { enable = false }
                    }
                }
            }
        end
    },
}

-- Install language servers
for _, server_config in pairs(servers) do
    local server_name, _ = unpack(server_config)
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available and not server:is_installed() then
        server:install()
    end
end

-- Setup language servers
for _, server_config in pairs(servers) do
    local server_name, setup_table = unpack(server_config)
    if setup_table then
        lspconfig[server_name].setup(setup_table())
    else
        lspconfig[server_name].setup{}
    end
end

