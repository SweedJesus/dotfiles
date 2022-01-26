-- Install language servers
local servers = {
    "graphql",
    "html",
    "jedi_language_server"
    -- "sumneko_lua"
}
local lsp_installer = require('nvim-lsp-installer.servers')
for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer.get_server(server_name)
    if not server_available then
        server:install()
    end
end

