local Snacks = require('snacks')

-- Picker
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.smart() end, {})
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.grep() end, {})
vim.keymap.set('n', '<leader>jj', function() Snacks.picker.buffers() end, {})
vim.keymap.set('n', '<leader>fh', function() Snacks.picker.comand_history() end, {})

-- LazyGit
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, {})
