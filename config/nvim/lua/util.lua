local M = {}

-- Global key mapper
function M.map(mode, lhs, rhs, opts)
    local def_opts = { noremap = true, silent = true }
    if opts == nil then opts = {} end
    local keyopts = vim.tbl_extend('force', def_opts, opts)
    vim.keymap.set(mode, lhs, rhs, keyopts)
    -- vim.api.nvim_set_keymap(mode, lhs, rhs, keyopts)
end

-- Buffer key mapper, use only inside attachment
function M.map_buf(mode, lhs, rhs, opts)
    local def_opts = { noremap = true, silent = true }
    if opts == nil then opts = {} end
    local keyopts = vim.tbl_extend('force', def_opts, opts)
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, keyopts)
end

-- Convenient options setter
function M.opts()
    local opts_info = vim.api.nvim_get_all_options_info()
    return setmetatable({}, {
        __newindex = function(_, key, value)
            vim.o[key] = value
            local scope = opts_info[key].scope
            if scope == 'win' then
                vim.wo[key] = value
            elseif scope == 'buf' then
                vim.bo[key] = value
            end
        end
    })
end

return M
