local harpoon = require("harpoon")

harpoon:setup({})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>kk", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end)

vim.keymap.set("n", "<leader>d1", function() harpoon:list():removeAt(1) end)
vim.keymap.set("n", "<leader>d2", function() harpoon:list():removeAt(2) end)
vim.keymap.set("n", "<leader>d3", function() harpoon:list():removeAt(3) end)
vim.keymap.set("n", "<leader>d4", function() harpoon:list():removeAt(4) end)
vim.keymap.set("n", "<leader>d5", function() harpoon:list():removeAt(5) end)
vim.keymap.set("n", "<leader>d6", function() harpoon:list():removeAt(6) end)
vim.keymap.set("n", "<leader>d7", function() harpoon:list():removeAt(7) end)
vim.keymap.set("n", "<leader>d8", function() harpoon:list():removeAt(8) end)
vim.keymap.set("n", "<leader>d9", function() harpoon:list():removeAt(9) end)



-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-h>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():next() end)
