require('avante').setup({
provider = 'copilot',
    providers = {
        copilot = {
            model = "claude-3.7-sonnet",
            timeout = 30000, -- Timeout in milliseconds
        },
    },
    selector = {
        exclude_auto_select = { "oil" },
    },
})
