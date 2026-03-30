return {
  "jmmarotta/openplan.nvim",
  -- dir = "/Users/julianmarotta/projects/openplan.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  keys = {
    {
      "<leader>pp",
      "<cmd>OpenPlan<cr>",
      desc = "[P]lan [P]icker",
    },
    {
      "<leader>pn",
      "<cmd>OpenPlanNew<cr>",
      desc = "[P]lan [N]ew",
    },
  },
  opts = {},
}
