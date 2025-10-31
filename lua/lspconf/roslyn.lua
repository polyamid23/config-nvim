local my_config = require("lspconf")

vim.lsp.config("roslyn", {
	on_attach = my_config.on_attach,
	capabilities = my_config.capabilities,
	settings = {
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
		},
		["csharp|code_lens"] = {

			dotnet_enable_references_code_lens = true,
		},
	},
})