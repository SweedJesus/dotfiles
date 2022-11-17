vim.cmd([[
augroup PACKER_COMPILE_ONCHANGE
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
augroup END
]])


local util = require("util")
-- local map = util.map
-- local map_buf = util.map_buf
local gopts = util.opts();

-- Install package manager (Packer) if it"s not there
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    -- vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim ".. install_path)
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end
vim.cmd([[packadd packer.nvim]])

require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    -- =============================================================================================
    -- Colorscheme/theme
    -- =============================================================================================
    use "shaunsingh/nord.nvim"
    -- use "Th3Whit3Wolf/one-nvim"
    gopts.termguicolors = true
    -- vim.cmd([[set background=light]])
    -- vim.cmd([[colorscheme one-nvim]])
    vim.cmd([[colorscheme nord]])

    -- =============================================================================================
    -- Status line
    -- =============================================================================================
    use "kyazdani42/nvim-web-devicons"
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
    require("lualine").setup {}

    -- =============================================================================================
    -- Fuzzy-finder
    -- =============================================================================================
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" }
        },
        config = function() require("plugins.telescope") end,
    }

    -- This shit is crazy
    -- https://github.com/ggandor/lightspeed.nvim
    -- https://www.youtube.com/watch?v=ESyld9NCl1w
    -- NOTE: use `cl` for `s` and `cc` for `S` replacements
    use {
        "ggandor/lightspeed.nvim",
        config = function() require("plugins.lightspeed") end,
    }

    -- =============================================================================================
    -- Filetree
    -- =============================================================================================
    use {
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function() require("plugins.filetree").nvim_tree() end,
    }
    -- use {
    --     "scrooloose/nerdtree",
    --     requires = { "ryanoasis/vim-devicons" },
    --     config = function() require("plugins.filetree").nerdtree() end
    -- }

    -- =============================================================================================
    -- Non LSP filtype plugins
    -- =============================================================================================
    use {
        "Vimjas/vim-python-pep8-indent",
        ft = { "python" },
    }
    use "simrat39/rust-tools.nvim"

    -- =============================================================================================
    -- LSP and linting
    -- =============================================================================================
    -- Setup language servers
    use "onsails/lspkind-nvim"
    use {
        "neovim/nvim-lspconfig",
        -- after = "nvim-cmp",
        requires = {
            "williamboman/nvim-lsp-installer",
            "jose-elias-alvarez/null-ls.nvim",
            -- "ray-x/lsp_signature.nvim",
        },
        config = function() require("plugins.nvim-lsp") end,
    }
    -- use {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     config = function() require("plugins.null-ls") end,
    -- }
    -- use {
    --     "mfussenegger/nvim-lint",
    --     config = function() require("plugins.nvim-lint") end,
    -- }
    use {
        'simrat39/symbols-outline.nvim',
        config = function() require("plugins.symbols-outline") end,
    }

    -- =============================================================================================
    -- Snippets and completion
    -- =============================================================================================
    use {
        "L3MON4D3/LuaSnip",
        -- requires = { "rafamadriz/friendly-snippets" },
        config = function() require("plugins.LuaSnip") end,
    }
    use {
        "hrsh7th/nvim-cmp",
        config = function() require("plugins.nvim-cmp") end,
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
        }
    }
    -- use "nvim-lua/lsp_extensions.nvim"
    -- use "folke/lsp-colors.nvim"

    -- =============================================================================================
    -- Treesitter
    -- =============================================================================================
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function() require("plugins.nvim-treesitter") end
    }

    -- =============================================================================================
    -- Miscelaneous quality of life
    -- =============================================================================================
    use {
        "Pocco81/TrueZen.nvim",
        config = function()
            require("true-zen").setup({
                modes = {
                    ataraxis = {
                        left_padding = 0,
                        right_padding = 0,
                        top_padding = 10,
                        bottom_padding = 10,
                        ideal_writing_area_width = { 105 },
                    }
                }
            })
        end,
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    -- TODO: replace with https://github.com/numToStr/Comment.nvim
    use {
        "terrortylor/nvim-comment",
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts_ns = { noremap = false, silent = true }

            require('nvim_comment').setup {
                hook = function()
                    if vim.api.nvim_buf_get_option(0, 'filetype') == 'vue' then
                        require('ts_context_commentstring.internal').update_commentstring()
                    end
                end
            }
            -- vim.api.nvim_set_keymap(
            --     'n',
            --     'gff',
            --     'v:lua.require"commented".codetags.fixme_line()',
            --     {
            --         expr = true,
            --         silent = true,
            --         noremap = true,
            --     },
            -- )
            -- map('i', '<C-_>', [[:CommentToggle<cr>]], opts_ns)
            map('n', '<tab>', [[:CommentToggle<cr>]], opts_ns)
            map('v', '<tab>', [[:<C-u>call CommentOperator(visualmode())<CR>]], opts_ns)
        end,
    }
    use "tpope/vim-surround" -- Surround motions
    use "tpope/vim-repeat" -- Dot can do more things
    use "godlygeek/tabular" -- Auto-tabulation
    use {
        "lukas-reineke/indent-blankline.nvim", -- Show indent levels
        config = function()
            require('indent_blankline').setup {
                filetype_exclude = {
                    'alpha',
                    'lspinfo',
                    'packer',
                    'checkhealth',
                    'help',
                    '',
                },
                use_treesitter = true,
                char = '│',
                context_char = '┃',
                show_first_indent_level = false,
                show_current_context = true,
                show_current_context_start = true,
                show_current_context_start_on_current_line = false,
                show_trailing_blankline_indent = false,
            }
        end,
    }
    use {
        "folke/todo-comments.nvim", -- Highlight todo/note comments
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require('todo-comments').setup {
                keywords = {
                    DANGER = {
                        icon = "!",
                        color = "danger"
                    },
                    HACK = {
                        icon = " ",
                        color = "warning"
                    },
                    WARN = {
                        icon = " ",
                        color = "warning",
                        alt = { "WARNING", "XXX" }
                    },
                    NOTE = {
                        icon = " ",
                        color = "hint",
                        alt = { "INFO" }
                    },
                    TODO = {
                        icon = " ",
                        color = "info"
                    },
                    PERF = {
                        icon = " ",
                        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
                    },
                    TEST = {
                        icon = "⏲ ",
                        color = "test",
                        alt = { "TESTING", "PASSED", "FAILED" }
                    },
                },
                colors = {
                    error = {
                        "#DC2626",
                        -- BUG:
                    },
                    danger = {
                        "#F98E22",
                        -- DANGER:
                    },
                    warning = {
                        "#FBBF24",
                        -- WARNING:
                    },
                    hint = {
                        "#10B981",
                        -- INFO:
                        -- !:
                    },
                    info = {
                        "#2563EB",
                        -- TODO:
                    },
                    default = {
                        "#7C3AED",
                        -- PERF:
                    },
                    test = {
                        "#FF00FF",
                        -- TEST:
                    },
                },
            }
        end,
    }
    use {
        "windwp/nvim-ts-autotag", -- Add matching HTML tag
        config = function()
            require 'nvim-ts-autotag'.setup {
                autotag = { enable = true }
            }
        end,
    }
    use {
        "norcalli/nvim-colorizer.lua",
        -- e.g. #558817 #a33243 #4269a8
        config = function() require("colorizer").setup() end,
    }
    -- https://github.com/sbdchd/neoformat

    -- Annotation/docummentation generator
    -- https://github.com/danymat/neogen
    use {
        "danymat/neogen",
        requires = { "nvim-treesitter/nvim-treesitter" },
        after = "nvim-treesitter",
        config = function()
            require("neogen").setup({
                enabled = true,
            })
        end,
    }

    -- Maybe these two can play together?
    -- https://github.com/goolord/alpha-nvim
    -- https://github.com/Shatur/neovim-session-manager

    use {
        "goolord/alpha-nvim",
        config = function() require("plugins.alpha") end,
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- TODO: should probably move all the config/setup stuff down here
