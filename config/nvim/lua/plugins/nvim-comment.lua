local util = require('util')
local map = util.map
--
--require('nvim_comment').setup{
--    hook = function()
--        if vim.api.nvim_buf_get_option(0, 'filetype') == 'vue' then
--            require('ts_context_commentstring.internal').update_commentstring()
--        end
--    end
--}

-- map('n', '<tab>', 'gcc', { noremap = false })
-- map('v', '<tab>', 'gc', { noremap = false })

vim.api.nvim_set_keymap(
    'n',
    'gff',
    'v:lua.require"commented".codetags.fixme_line()',
    { expr = true, silent = true, noremap = true })

