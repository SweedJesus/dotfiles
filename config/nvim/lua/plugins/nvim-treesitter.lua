require('nvim-treesitter.configs').setup({
    ensure_installed ={
        'bash',
        'c',
        'cpp',
        'css',
        'graphql',
        'html',
        'http',
        'javascript',
        'json',
        'lua',
        'python',
        'rust',
        'scss',
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
})

-- vim.g.foldlevelstart = 99
vim.wo.foldlevel = 1
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldcolumn = 'auto'
