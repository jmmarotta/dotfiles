-- General Git command/status/object layer.
-- codediff.nvim owns visual diff/review; fugitive owns status, staging, commits,
-- blame, and arbitrary git commands. No setup() call is needed.
return {
  "tpope/vim-fugitive",
  cmd = {
    "Git",
    "G",
    "Gedit",
    "Gsplit",
    "Gvsplit",
    "Gtabedit",
    "Gdiffsplit",
    "Gvdiffsplit",
    "Gread",
    "Gwrite",
    "Gclog",
    "Gllog",
  },
  keys = {
    { "<leader>gg", "<cmd>Git<cr>", desc = "[G]it Status (fugitive)" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "[G]it [B]lame" },
  },
}
