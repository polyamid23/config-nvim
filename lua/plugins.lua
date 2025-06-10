local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- themes
    { 'gruvbox-community/gruvbox' },
    -- gitsigns
    { 'lewis6991/gitsigns.nvim' },
    -- tpope commentary
    { 'tpope/vim-commentary' },

    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- formatter
            {
                'stevearc/conform.nvim',
                opts = {
                    formatters_by_ft = {
                        htmlangular = { "prettier" },
                    },
                },
            },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
            { 'nvim-cmp' },
            -- { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
        }
    },
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        -- @module 'roslyn.config'
        -- @type RoslynNvimConfig
        opts = {
            -- your configuration comes here; leave empty for default settings
        },
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    { 'mhinz/vim-startify' },
}, opts)


local files = vim.split(vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/plugin', '*.lua', true), '\n')

for _, f in ipairs(files) do
    local name = vim.fn.fnamemodify(f, ':t:r')
    require('plugin.' .. name)
end
