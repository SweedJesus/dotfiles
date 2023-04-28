local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "static/legacy",
            "dist",
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            -- '--no-heading',
            '--with-filename',
            '--column',
            '--smart-case', -- search case sensitively
            '--follow', -- follow symlinks
            '-u', -- unrestritect (search hidden files)
        },
        mappings = {
            i = {
                ['<C-n>'] = false,
                ['<C-p>'] = false,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            },
            n = {
                ['<C-n>'] = false,
                ['<C-p>'] = false,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            }
        }
    }
}

local extensions = {
    'fzf',
    'live_grep_args',
}
pcall(function()
    for _, ext in ipairs(extensions) do
        telescope.load_extension(ext)
    end
end)

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>tt', [[:lua require('telescope.builtin').builtin()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>tf', [[:lua require('telescope.builtin').find_files()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>tb', [[:lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>tm', [[:lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    opts)
vim.api.nvim_set_keymap('n', '<leader>to', [[:lua require('telescope.builtin').oldfiles()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>tg', [[:lua require('telescope.builtin').grep_string()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>tl', [[:lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]],
    opts)
-- .quickfix
-- .loclist
-- .jumplist
-- .spell_suggest

-- map('n', '<leader>f',   [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
-- map('n', '<leader>b',   [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
-- map('n', '<leader>m',   [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])
-- map('n', '<leader>t',   [[<cmd>lua require('telescope.builtin').tags()<cr>]])
-- map('n', '<leader>?',   [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]])
-- map('n', '<leader>sd',  [[<cmd>lua require('telescope.builtin').grep_string()<cr>]])
-- map('n', '<leader>sp',  [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
-- map('n', '<leader>o',   [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<cr>]])
-- map('n', '<leader>gc',  [[<cmd>lua require('telescope.builtin').git_commits()<cr>]])
-- map('n', '<leader>gb',  [[<cmd>lua require('telescope.builtin').git_branches()<cr>]])
-- map('n', '<leader>gs',  [[<cmd>lua require('telescope.builtin').git_status()<cr>]])
-- map('n', '<leader>gp',  [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]])
