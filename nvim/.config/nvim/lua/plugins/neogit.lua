return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "sindrets/diffview.nvim",
    "folke/snacks.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "[G]it [G]ui" },
  },
  opts = {
    integrations = {
      diffview = true,
      snacks = true,
    },
  },
}
