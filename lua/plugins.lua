local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
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
      { 'neovim/nvim-lspconfig' },       -- Required
      {                                  -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },       -- Optional
      -- formatter
      {
        'stevearc/conform.nvim',
        opts = {},
      },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },           -- Required
      { 'hrsh7th/cmp-nvim-lsp' },       -- Required
      { 'L3MON4D3/LuaSnip' },           -- Required
      { 'nvim-cmp' },
      -- { 'github/copilot.vim' },
      { 'mhinz/vim-startify' },
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",       -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = true,
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}, opts)


local files = vim.split(vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/plugin', '*.lua', true), '\n')

for _, f in ipairs(files) do
  local name = vim.fn.fnamemodify(f, ':t:r')
  require('plugin.' .. name)
end
