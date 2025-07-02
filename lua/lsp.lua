local loaded_configs = require('lspconfig.configs')
local lspconfig = require('lspconfig')
local my_config = require('lspconf')

local function load_custom_configs()
    local config_files = vim.split(vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/lspconf', '*.lua', true), '\n')

    for _, f in ipairs(config_files) do
        local name = vim.fn.fnamemodify(f, ':t:r')
        require('lspconf.' .. name)
    end
end

local function setup_default_configs()
    local available_servers = require('mason-lspconfig').get_installed_servers()
    local config = my_config
    local excluded = { angularls = true, roslyn = true }

    for _, server in pairs(available_servers) do
        if loaded_configs[server] or excluded[server] then
            goto continue
        end

        lspconfig[server].setup(config)
        vim.lsp.config(server, config)

        ::continue::
    end
end

load_custom_configs()
setup_default_configs()
