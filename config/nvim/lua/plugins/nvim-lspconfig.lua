local lspconfig = require('lspconfig')
-- Lua
-- local lua_runtime_path = vim.split(package.path, ';')
-- table.insert(lua_runtime_path, 'lua/?.lua')
-- table.insert(lua_runtime_path, 'lua/?/init.lua')
-- lspconfig.sumneko_lua.setup{
--     settings = {
--         Lua = {
--             runtime = {
--                 version = 'LuaJIT',
--                 path = lua_runtime_path,
--             },
--             diagnostics = { globals = {'vim'} },
--             workspace = { library = vim.api.nvim_get_runtime_file('', true) },
--             telemetry = { enable = false }
--         }
--     }
-- }
-- GraphQL
lspconfig.graphql.setup{}
-- Python
lspconfig.jedi_language_server.setup{}

