require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- map leader gj to go to next hunk
        map('n', '<leader>gj', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- map leader gk to go to previous hunk
        map('n', '<leader>gk', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '<leader>gp', gs.preview_hunk)
        map('n', '<leader>gs', gs.stage_hunk)
        map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>gu', gs.reset_hunk)

        -- nnoremap <leader>glf :!smerge log %<CR>
        map('n', '<leader>glf', function()
            vim.fn.system('smerge log ' .. vim.fn.expand('%'))
        end)
        -- nnoremap <leader>gbf :!smerge blame % line('.')<CR>
        map('n', '<leader>gbf', function()
            vim.fn.system('smerge blame ' .. vim.fn.expand('%') .. ' ' .. vim.fn.line('.'))
        end)

    end
}
