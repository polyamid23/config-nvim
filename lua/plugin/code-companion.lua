require("codecompanion").setup({
  strategies = {
    chat = {
        adapter = {
            name = "copilot",
            model = "claude-3.7-sonnet",
          },
    },
  },
})
