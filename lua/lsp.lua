local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')
local loaded_configs = require('lspconfig.configs')

local function get_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return {
    capabilities = capabilities,
  }
end

local function load_custom_configs()
  local config_files = vim.split(vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/lspconf', '*.lua', true), '\n')

  for _, f in ipairs(config_files) do
    local name = vim.fn.fnamemodify(f, ':t:r')
    require('lspconf.' .. name)
  end
end

local function setup_default_configs()
  local available_servers = require('mason-lspconfig').get_installed_servers()
  for _, server in pairs(available_servers) do
    if not loaded_configs[server] then
      local config = get_config()
      lspconfig[server].setup(config)
    end
  end
end

load_custom_configs()
setup_default_configs()

lsp.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false, }
  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
end)

lsp.setup()

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
