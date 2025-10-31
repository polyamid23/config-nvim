local my_config = require("lspconf")

local function get_custom_server_names()
	local config_files = vim.split(vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/lspconf", "*.lua", true), "\n")
	local custom_servers = {}

	for _, f in ipairs(config_files) do
		local name = vim.fn.fnamemodify(f, ":t:r")
		custom_servers[name] = true
	end

	return custom_servers
end

local function load_custom_configs()
	local config_files = vim.split(vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/lspconf", "*.lua", true), "\n")

	for _, f in ipairs(config_files) do
		local name = vim.fn.fnamemodify(f, ":t:r")
		require("lspconf." .. name)
	end
end

load_custom_configs()

local available_servers = require("mason-lspconfig").get_installed_servers()
local config = my_config
local custom_servers = get_custom_server_names()
-- Always exclude these special cases
-- custom_servers.stylua = true

for _, server in pairs(available_servers) do
	if not custom_servers[server] then
		vim.lsp.config(server, config)
	end

	vim.lsp.enable(server)
end
