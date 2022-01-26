vim.cmd([[
augroup PACKER_COMPILE_ONCHANGE
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
augroup END
]])

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
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    require('lualine').setup{}

    -- =============================================================================================
    -- Fuzzy-finder
    -- =============================================================================================
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'}
        },
        config = function() require('plugins.telescope') end
    }

    -- =============================================================================================
    -- Filetree
    -- =============================================================================================
    use {
        'scrooloose/nerdtree',
        requires = { 'ryanoasis/vim-devicons' },
    }
    -- TODO: move this to a plugin file (others?)
    map('n', '<leader>n', [[<cmd>NERDTreeToggle<cr>]])

    -- =============================================================================================
    -- LSP
    -- =============================================================================================
    -- Setup language servers
    use {
        'neovim/nvim-lspconfig',
        requires = { 'williamboman/nvim-lsp-installer' },
        -- config = function() require('plugins.nvim-lspconfig') end
        config = function() require('plugins.nvim-lsp') end
    }
    use 'onsails/lspkind-nvim'

    -- =============================================================================================
    -- Snippets and completion
    -- =============================================================================================
    use 'L3MON4D3/LuaSnip'
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugins.nvim-cmp') end,
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
        }
    }
    -- use 'nvim-lua/lsp_extensions.nvim'
    -- use 'folke/lsp-colors.nvim'

    -- =============================================================================================
    -- Treesitter
    -- =============================================================================================
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.nvim-treesitter') end
    }

    -- =============================================================================================
    -- Miscelaneous quality of life
    -- =============================================================================================
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use {
        'terrortylor/nvim-comment',
        config = function() require('plugins.others').nvim_comment() end
    }
    use 'tpope/vim-surround' -- Surround motions
    use 'tpope/vim-repeat' -- Dot can do more things
    use 'godlygeek/tabular' -- Auto-tabulation
    use {
        'lukas-reineke/indent-blankline.nvim', -- Show indent levels
        config = function() require('plugins.others').indent_blankline() end
    }
    use {
        'folke/todo-comments.nvim', -- Highlight todo/note comments
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('plugins.others').todo_comments() end
    }
    use {
        'windwp/nvim-ts-autotag', -- Add matching HTML tag
        config = function() require('plugins.others').nvim_ts_autotag() end
    }
end)
