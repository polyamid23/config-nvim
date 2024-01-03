local neotree = require("neo-tree")

neotree.setup({
  buffers = {
    follow_current_file = {
      enabled = true,
    },
  },
  window = {
    position = "right",
  },
})
