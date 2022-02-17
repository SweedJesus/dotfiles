local util = require("util")
local map = util.map
require("lint").linters_by_ft = {
    python = {
        -- "mypy",
        -- "pycodestyle",
        -- "pydocstyle",
        -- "flake8",
        "pylint",
    },
}
-- TODO: Only run this within Python contexts
require("lint.linters.mypy").args = {
    "--show-column-numbers",
    "--hide-error-codes",
    "--hide-error-context",
    "--no-color-output",
    "--no-error-summary",
    "--no-pretty",
    "--strict",
}

local opts = { noremap = false }
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

vim.api.nvim_exec([[
augroup PythonLint
    autocmd!
    autocmd BufWritePost <buffer> lua require("lint").try_lint()
augroup end
]], false)
