local lspconfig = require 'lspconfig'

-- Angular requires a node_modules directory to probe for @angular/language-service and typescript
-- in order to use your projects configured versions.
-- This defaults to the vim cwd, but will get overwritten by the resolved root of the file.
local function get_probe_dir(root_dir)
  local project_root = vim.fs.dirname(vim.fs.find('node_modules', { path = root_dir, upward = true })[1])

  return project_root and (project_root .. '/node_modules') or ''
end

local function get_angular_core_version(root_dir)
  local project_root = vim.fs.dirname(vim.fs.find('node_modules', { path = root_dir, upward = true })[1])

  if not project_root then
    return ''
  end

  local package_json = project_root .. '/package.json'
  if not vim.uv.fs_stat(package_json) then
    return ''
  end

  local contents = io.open(package_json):read '*a'
  local json = vim.json.decode(contents)
  if not json.dependencies then
    return ''
  end

  local angular_core_version = json.dependencies['@angular/core']

  angular_core_version = angular_core_version and angular_core_version:match('%d+%.%d+%.%d+')

  return angular_core_version
end

local default_probe_dir = get_probe_dir(vim.fn.getcwd())
local default_angular_core_version = get_angular_core_version(vim.fn.getcwd())

local cmd = {
    'node',
    '--max-old-space-size=8192',
    vim.fn.exepath('ngserver'),
    '--stdio',
    '--tsProbeLocations',
    default_probe_dir,
    '--ngProbeLocations',
    default_probe_dir,
    '--angularCoreVersion',
    default_angular_core_version,
}

local config = {
  cmd = cmd,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
  on_attach = function()
    for _, server in ipairs(vim.lsp.get_clients()) do
      if server.name == "ts_ls" then
        local tsserver = vim.lsp.get_client_by_id(server.id)
        tsserver.server_capabilities.renameProvider = false
      end
    end
  end
}

lspconfig.angularls.setup(config)

