local map = vim.api.nvim_set_keymap
local opts_ns = { noremap = false, silent = true }

local M = {}

M.nvim_comment = function()
    require('nvim_comment').setup{}
    map('i', '<C-_>', [[<C-o><cmd>CommentToggle<CR><C-o>A]], opts_ns)
    map('n', '<C-_>', [[<cmd>CommentToggle<CR>]], opts_ns)
    map('v', '<C-_>', [[:<C-u>call CommentOperator(visualmode())<CR>]], opts_ns)
end

M.todo_comments = function()
    require('todo-comments').setup{}
end

M.indent_blankline = function()
    require('indent_blankline').setup{
        space_char_blankline = ' ',
        show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = true,
        show_current_context_start_on_current_line = false,
        show_end_of_line = true,
    }
end

M.nvim_ts_autotag = function()
    require'nvim-ts-autotag'.setup{
        autotag = { enable = true }
    }
end

return M
