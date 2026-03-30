return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iffview [O]pen" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it File [H]istory" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "[G]it Branch [H]istory" },
    { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "[G]it [D]iffview [C]lose" },
  },
  opts = {},
}
