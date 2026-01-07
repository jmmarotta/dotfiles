return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it File [H]istory" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "[G]it Branch [H]istory" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "[G]it Diffview [C]lose" },
  },
  opts = {},
}
