local util = require('util')
local map = util.map
local map_buf = util.map_buf
local opts = util.opts();

-- Install package manager (Packer) if it's not there
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end
vim.api.nvim_exec([[
augroup Packer
autocmd!
autocmd BufWritePost init.lua PackerCompile
augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'                -- Package manager
    use 'rakr/vim-one'                          -- Atom One theme
    use 'shaunsingh/nord.nvim'                  -- Nord theme
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    -- use 'tpope/vim-commentary'                  -- 'gc' to comment visual regions/lines
    use 'terrortylor/nvim-comment'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'godlygeek/tabular'
    -- use 'ludovicchabant/vim-gutentags'       -- Automatic tags management
    use {                                       -- UI to select things (files, grep results, open buffers...)
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'}
        }
    }
    -- use 'joshdick/onedark.vim'               -- Theme inspired by Atom
    use 'itchyny/lightline.vim'                 -- Fancier statusline
    -- use {                                       -- Add indentation guides even on blank lines
    --     'lukas-reineke/indent-blankline.nvim',
    --     branch='lua'
    -- }
    -- use 'tpope/vim-fugitive'                 -- Git commands in nvim
    -- use 'tpope/vim-rhubarb'                  -- Fugitive-companion to interact with github
    -- use {                                    -- Add git related info in the signs columns and popups
    --     'lewis6991/gitsigns.nvim',
    --     requires = {'nvim-lua/plenary.nvim'}
    -- }
    -- use {
    --     'kyazdani42/nvim-tree.lua',
    --     requires = {
    --         'kyazdani42/nvim-web-devicons', -- optional, for file icon
    --     },
    --     config = function() require'nvim-tree'.setup {} end
    -- }
    use 'ryanoasis/vim-devicons'
    use 'scrooloose/nerdtree'
    -- use 'L3MON4D3/LuaSnip'
    -- use 'kevinhwang91/rnvimr'                   -- Ranger from inside neovim
    --
    -- CoC stuff
    -- use {
    --     'neoclide/coc.nvim',
    --     branch='release'
    -- }
    --
    -- Native LSP stuff:
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- use 'nvim-lua/lsp_extensions.nvim'          -- Extensions to built-in LSP
    -- use 'folke/lsp-colors.nvim'
    -- use 'hrsh7th/nvim-compe'                    -- Autocompletion plugin
    --
    -- use 'nvim-lua/completion-nvim'           -- Autocompletion framework for built-in LSP
    -- use {
    --     'dense-analysis/ale',
    --     opt = true,
    --     ft = { 'c', 'cpp', 'go', 'rust', 'scala', 'python', 'objcpp', 'objc', 'reason' }
    -- }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
end)


local cmp = require('cmp')
cmp.setup({
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
        -- { name = 'vsnip' },
        -- { name = 'luasnip' },
        -- { name = 'ultisnips' },
        -- { name = 'snippy' },
    }, {
        { name = 'buffer' },
    })
})
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


require('nvim_comment').setup({
    hook = function()
        if vim.api.nvim_buf_get_option(0, 'filetype') == 'vue' then
            require('ts_context_commentstring.internal').update_commentstring()
        end
    end
})
require('todo-comments').setup()

-- =================================================================================================
-- Colorscheme
-- =================================================================================================

opts.termguicolors = true
-- vim.g.onedark_terminal_italics = 2
-- vim.cmd[[colorscheme onedark]]
-- vim.cmd('colorscheme one')
vim.cmd('colorscheme nord')
-- vim.cmd('set background=light')

-- =================================================================================================
-- Status bar (lightline)
-- =================================================================================================

vim.g.lightline = {
    colorscheme = 'one';
    active = {
        left = {
            { 'mode', 'paste' },
            { 'gitbranch', 'readonly', 'filename', 'modified' }
        }
    };
    component_function = { gitbranch = 'fugitive#head', };
}

-- =================================================================================================
-- File tree (nvim-tree)
-- =================================================================================================

-- require'nvim-tree'.setup {
-- }

-- vim.cmd([[highlight NvimTreeFolderIcon guibg=blue]])
-- vim.g.nvim_tree_width = 40
-- vim.g.nvim_tree_gitignore = 1
-- vim.g.nvim_tree_auto_close = 1
-- vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }
-- vim.g.nvim_tree_follow = 1
-- vim.g.nvim_tree_indent_markers = 1
-- vim.g.nvim_tree_git_hl = 1
-- vim.g.nvim_tree_width_allow_resize  = 1
-- vim.g.nvim_tree_add_trailing = 1
-- vim.g.nvim_tree_group_empty = 1
-- vim.g.nvim_tree_lsp_diagnostics = 1
-- vim.g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE' }
-- vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }
-- vim.g.nvim_tree_icons = {
--     default = '',
--     symlink = '',
--     git = {
--         unstaged = '✗',
--         staged = '✓',
--         unmerged = '',
--         renamed = '➜',
--         untracked = '★',
--         deleted = '',
--         ignored = '◌'
--     },
--     folder = {
--         default = '',
--         open = '',
--         empty = '',
--         empty_open = '',
--         symlink = '',
--         symlink_open = '',
--     },
--     lsp = {
--         hint = '',
--         info = '',
--         warning = '',
--         error = '',
--     }
-- }

-- require('nvim-tree.events').on_nvim_tree_ready(function ()
--     vim.g.nvim_tree_ready = 1
-- end)

-- function update_cwd()
--     if vim.g.nvim_tree_ready == 1 then
--         local view = require('nvim-tree.view')
--         local lib = require('nvim-tree.lib')
--         if view.win_open() then
--             lib.change_dir(vim.fn.getcwd())
--         end
--     end
-- end

-- vim.api.nvim_exec([[
-- augroup NvimTreeConfig
-- au!
-- au DirChanged * lua update_cwd()
-- augroup END
-- ]], false)

-- Change directory to openned file
-- vim.cmd([[cd %<]])

-- =================================================================================================
-- Telescope
-- =================================================================================================

require('telescope').setup {
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

-- =================================================================================================
-- Language server (LSP)
-- =================================================================================================

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- require('lspconfig')[server].setup {
    -- capabilities = capabilities
-- }

-- --Incremental live completion
-- opts.inccommand = 'nosplit'
-- 
-- -- Set completeopt to have a better completion experience
-- opts.completeopt='menuone,noselect'
-- 
local lsp_installer = require('nvim-lsp-installer')
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)
-- 
-- -- TODO: Figure out how to setup the html server between lsp_installer AND lspconfig
-- 
local lsp_config = require('lspconfig')
-- 
-- -- lsp_config.sumneko_lua
-- 
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',           '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',           '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',            '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',           '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>',        '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa',   '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr',   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D',    '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn',   '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',           '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',   '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    -- TODO: migrate
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e',    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d',           '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d',           '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>,',    '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
end
-- 
-- -- require'lspconfig'.vuels.setup{}
-- 
-- -- local servers = { 'clangd', 'gopls', 'rust_analyzer', 'rnix', 'hls', 'dartls', 'pyre', 'gdscript' }
local servers = {
    -- 'rust_analyzer',
    -- 'html',
    -- 'vuels',
    'graphql',
}
for _, lsp in ipairs(servers) do
    lsp_config[lsp].setup {
        -- on_attach = on_attach,
        capabilities = capabilities,
    }
end
-- 
-- -- lsp_config.vuels.setup {
-- --     on_attach = function(client)
-- --         --[[
-- --         Internal Vetur formatting is not supported out of the box
-- -- 
-- --         This line below is required if you:
-- --         - want to format using Nvim's native `vim.lsp.buf.formatting**()`
-- --         - want to use Vetur's formatting config instead, e.g, settings.vetur.format {...}
-- --         --]]
-- --         client.resolved_capabilities.document_formatting = true
-- --         on_attach(client)
-- --     end,
-- --     capabilities = capabilities,
-- --     settings = {
-- --         vetur = {
-- --             completion = {
-- --                 autoImport = true,
-- --                 useScaffoldSnippets = true
-- --             },
-- --             format = {
-- --                 defaultFormatter = {
-- --                     html = 'none',
-- --                     js = 'prettier',
-- --                     -- ts = 'prettier',
-- --                 }
-- --             },
-- --             validation = {
-- --                 template = true,
-- --                 script = true,
-- --                 style = true,
-- --                 templateProps = true,
-- --                 interpolation = true
-- --             },
-- --             experimental = {
-- --                 templateInterpolationService = true
-- --             }
-- --         }
-- --     },
--     -- root_dir = lsp_config.util.root_pattern('package.json')
-- -- }
-- 
-- -- local util = lsp_config.util.root_pattern
-- 
-- -- Enable diagnostics
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
-- vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
-- }
-- )
-- 
-- -- Show diagnostics on cursor
-- -- TODO: migrate
-- -- vim.api.nvim_exec('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()', false)
-- 
-- -- Type inlay hints
-- -- vim.api.nvim_exec([[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = 'Comment', enabled = { 'TypeHint', 'ChainingHint', 'ParameterHint'} }]], false)
-- 
-- =================================================================================================
-- Luasnip
-- =================================================================================================

-- local luasnip = require('luasnip')

-- =================================================================================================
-- Compe
-- =================================================================================================

-- require('compe').setup {
--     -- enabled = true;
--     -- autocomplete = true;
--     -- debug = false;
--     -- min_length = 1;
--     -- preselect = 'enable';
--     -- throttle_time = 80;
--     -- source_timeout = 200;
--     -- incomplete_delay = 400;
--     -- max_abbr_width = 100;
--     -- max_kind_width = 100;
--     -- max_menu_width = 100;
--     -- documentation = true;
--     source = {
--         path = true,
--         nvim_lsp = true,
--         buffer = true,
--         calc = true,
--         nvim_lua = true,
--         spell = true,
--         tags = false,
--         vsnip = false,
--         luasnip = true,
--         snippets_nvim = true,
--         treesitter = true,
--     };
-- }
-- 
-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- 
-- local check_back_space = function()
--     local col = vim.fn.col('.') - 1
--     if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--         return true
--     else
--         return false
--     end
-- end
-- 
-- -- Use tab and shift-tab to:
-- -- - move to prev/next item in completion menuone
-- -- - jump to prev/next snippet's placeholder
-- -- _G.tab_complete = function()
-- --     if vim.fn.pumvisible() == 1 then
-- --         return t '<C-n>'
-- --     elseif check_back_space() then
-- --         return t '<tab>'
-- --     else
-- --         return vim.fn['compe#complete']()
-- --     end
-- -- end
-- _G.tab_complete = function()
--     if vim.fn.pumvisible() == 1 then
--         return t '<C-n>'
--     elseif luasnip.expand_or_jumpable() then
--         return t '<Plug>luasnip-expand-or-jump'
--     elseif check_back_space() then
--         return t '<Tab>'
--     else
--         return vim.fn['compe#complete']()
--     end
-- end
-- 
-- -- _G.s_tab_complete = function()
-- --     if vim.fn.pumvisible() == 1 then
-- --         return t '<c-p>'
-- --     else
-- --         return t '<s-tab>'
-- --     end
-- -- end
-- _G.s_tab_complete = function()
--     if vim.fn.pumvisible() == 1 then
--         return t '<C-p>'
--     elseif luasnip.jumpable(-1) then
--         return t '<Plug>luasnip-jump-prev'
--     else
--         return t '<S-Tab>'
--     end
-- end

-- =================================================================================================
-- Other plugin mappings
-- =================================================================================================

-- Tab to toggle line indent
map('n', '<tab>', 'gcc', { noremap = false })
map('v', '<tab>', 'gc', { noremap = false })

require'plugins/treesitter'

