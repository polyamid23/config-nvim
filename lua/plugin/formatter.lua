local formatter = require("conform")

formatter.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettier" } },
  },
})
