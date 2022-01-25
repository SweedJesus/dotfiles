local util = require('util')
local map = util.map
-- local map_buf = util.map_buf
local gopts = util.opts();

-- Install package manager (Packer) if it's not there
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

local packer = require('packer')
local use = packer.use
packer.startup(function()
    use 'wbthomason/packer.nvim'

    -- =============================================================================================
    -- Colorscheme
    -- =============================================================================================
    use 'shaunsingh/nord.nvim'
    gopts.termguicolors = true
    vim.cmd('colorscheme nord')

    -- =============================================================================================
    -- Status line
    -- =============================================================================================
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
        end
    }
    require('lualine').setup{}

    -- =============================================================================================
    -- Comments
    -- =============================================================================================
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'terrortylor/nvim-comment'
    require('nvim_comment').setup{
        hook = function()
            if vim.api.nvim_buf_get_option(0, 'filetype') == 'vue' then
                require('ts_context_commentstring.internal').update_commentstring()
            end
        end
    }
    map('n', '<tab>', 'gcc', { noremap = false })
    map('v', '<tab>', 'gc', { noremap = false })

    -- =============================================================================================
    -- Fuzzy-finder
    -- =============================================================================================
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'}
        },
        config = function()
            require('telescope').setup{
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
                    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
                }
            }
        end
    }
    require('telescope').load_extension('fzf')

    -- =============================================================================================
    -- Filetree
    -- =============================================================================================
    use 'ryanoasis/vim-devicons'
    use 'scrooloose/nerdtree'

    -- =============================================================================================
    -- Snippets
    -- =============================================================================================
    -- use 'L3MON4D3/LuaSnip'

    -- =============================================================================================
    -- LSP
    -- =============================================================================================
    use 'williamboman/nvim-lsp-installer'
    -- Install language servers
    local servers = {
        "graphql",
        "html",
        "sumneko_lua"
    }
    local lsp_installer = require('nvim-lsp-installer.servers')
    for _, server_name in pairs(servers) do
        local server_available, server = lsp_installer.get_server(server_name)
        if not server_available then
            server:install()
        end
    end

    -- Setup language servers
    use 'neovim/nvim-lspconfig'
    local lspconfig = require('lspconfig')
    -- Lua
    local lua_runtime_path = vim.split(package.path, ';')
    table.insert(lua_runtime_path, 'lua/?.lua')
    table.insert(lua_runtime_path, 'lua/?/init.lua')
    lspconfig.sumneko_lua.setup{
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = lua_runtime_path,
                },
                diagnostics = { globals = {'vim'} },
                workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                telemetry = { enable = false }
            }
        }
    }
    -- GraphQL
    lspconfig.graphql.setup{}

    -- Other things
    use 'onsails/lspkind-nvim'

    -- =============================================================================================
    -- Completion
    -- =============================================================================================
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-cmdline'
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            local lspkind = require('lspkind')
            local cmp = require('cmp')
            cmp.setup{
                -- snippet = {
                --     expand = function(args)
                --         vim.fn['vsnip#anonymous'](args.body)
                --         -- require('luasnip').lsp_expand(args.body)
                --         -- vim.fn['UltiSnips#Anon'](args.body)
                --     end,
                -- },
                -- mapping = {
                --     ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
                --     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
                --     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
                --     ['<C-y>'] = cmp.config.disable,
                --     ['<C-e>'] = cmp.mapping({
                --         i = cmp.mapping.abort(),
                --         c = cmp.mapping.close(),
                --     }),
                --     ['<CR>'] = cmp.mapping.confirm({select = true}),
                -- },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer', keyword_length = 5 },
                }, {
                }),
                experimental = {
                    ghost_text = true,
                },
                formatting = {
                    format = lspkind.cmp_format({
                        -- with_text = false,
                        -- maxwidth = 50,
                        before = function(_, vim_item)
                            return vim_item
                        end,
                    })
                },
            }
            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' }
                }
            })
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    }
    -- use 'nvim-lua/lsp_extensions.nvim'
    -- use 'folke/lsp-colors.nvim'

    -- =============================================================================================
    -- Treesitter
    -- =============================================================================================
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.treesitter') end
    }

    -- =============================================================================================
    -- Miscelaneous quality of life
    -- =============================================================================================
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'godlygeek/tabular'
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup{
                show_end_of_line = true,
            }
        end
    }
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('todo-comments').setup{} end
    }
    use { -- Add matching HTML tag
        'windwp/nvim-ts-autotag',
        config = function() require'nvim-ts-autotag'.setup{} end
    }
end)

