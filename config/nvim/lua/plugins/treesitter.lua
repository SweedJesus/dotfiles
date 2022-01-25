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
    indent = { enable = true },
    highlight = { enable = true }
})

