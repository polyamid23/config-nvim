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
    { 'gruvbox-community/gruvbox' },
    { 'lewis6991/gitsigns.nvim' },
    { 'tpope/vim-commentary' },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- bigfile = { enabled = true },
            -- dashboard = { enabled = true },
            -- explorer = { enabled = true },
            -- animate = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            -- notifier = { enabled = true },
            -- quickfile = { enabled = true },
            -- scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            -- words = { enabled = true },
            lazygit = { enabled = true },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    { 'neovim/nvim-lspconfig' }, -- Required
    {                            -- Optional
        'williamboman/mason.nvim',
        build = function()
            pcall(vim.cmd, 'MasonUpdate')
        end,
    },
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    {
        'stevearc/conform.nvim',
    },
    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },     -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' },     -- Required
    -- roslyn
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {
            -- your configuration comes here; leave empty for default settings
        },
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        lazy = false,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    { 'mhinz/vim-startify' },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
	 {
	   "yetone/avante.nvim",
	   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	   -- ⚠️ must add this setting! ! !
	   build = function()
	     -- conditionally use the correct build system for the current OS
	     if vim.fn.has("win32") == 1 then
	       return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
	     else
	       return "make"
	     end
	
	   end,
	   event = "VeryLazy",
	   version = false, -- Never set this value to "*"! Never!
	
	   dependencies = {
	     "nvim-lua/plenary.nvim",
	     "MunifTanjim/nui.nvim",
	
	     --- The below dependencies are optional,
	
	     "echasnovski/mini.pick", -- for file_selector provider mini.pick
	     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
	     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
	     "ibhagwan/fzf-lua", -- for file_selector provider fzf
	     "stevearc/dressing.nvim", -- for input provider dressing
	     "folke/snacks.nvim", -- for input provider snacks
	     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	     "zbirenbaum/copilot.lua", -- for providers='copilot'
	     {
	       -- support for image pasting
	       "HakonHarnes/img-clip.nvim",
	       event = "VeryLazy",
	       opts = {
	 	-- recommended settings
	 	default = {
	
	 	  embed_image_as_base64 = false,
	 	  prompt_for_file_name = false,
	 	  drag_and_drop = {
	 	    insert_mode = true,
	 	  },
	 	  -- required for Windows users
	 	  use_absolute_path = true,
	 	},
	
	       },
	     },
	     {
	       -- Make sure to set this up properly if you have lazy=true
	       'MeanderingProgrammer/render-markdown.nvim',
	       opts = {
	 	file_types = { "markdown", "Avante" },
	       },
	       ft = { "markdown", "Avante" },
	     },
	   },
	 }
}, opts)


local files = vim.split(vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/plugin', '*.lua', true), '\n')

for _, f in ipairs(files) do
    local name = vim.fn.fnamemodify(f, ':t:r')
    require('plugin.' .. name)
end
