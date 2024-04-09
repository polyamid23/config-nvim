vim.keymap.set("n", "<leader>;;", ":Neotree toggle<CR>")
vim.keymap.set("n", "<leader>kk", ":Neotree reveal<CR>")

-- jk to escape
vim.keymap.set("i", "jk", "<Esc>")

-- allow moving line / lines in all modes with M-j/k
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- C-x to close buffer
vim.keymap.set("n", "<C-x>", ":bd<CR>")

-- C-l / C-h to go to nex / previouse buffer
vim.keymap.set("n", "<S-L>", ":bn<CR>")
vim.keymap.set("n", "<S-H>", ":bp<CR>")

-- leader-t-space 2 to set expandtab, shiftwidth, softtabstop to 2
vim.keymap.set("n", "<leader>t<Space>2", ":set expandtab shiftwidth=2 softtabstop=2<CR>")
vim.keymap.set("n", "<leader>t<Space>4", ":set expandtab shiftwidth=4 softtabstop=4<CR>")
vim.keymap.set("n", "<leader>t<Space><Tab>", ":set noexpandtab shiftwidth=4 softtabstop=4<CR>")
-- LazyGit
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
