-- https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        -- 'css',
        'graphql',
        'html',
        'http',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'rust',
        -- 'scss',
        'toml',
        'typescript',
        'vue',
    },
    indent = {
        -- NOTE: Indentation is too broken for python (sometimes for lua too)
        -- e.g. https://github.com/nvim-treesitter/nvim-treesitter/issues/1573
        enable = false,
        -- disable = { 'python' },
    },
    highlight = {
        enable = true,
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
})

-- vim.g.foldlevelstart = -1
vim.wo.foldlevel = 99
-- vim.wo.foldnestmax = 2
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldcolumn = 'auto'
