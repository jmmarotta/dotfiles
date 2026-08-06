return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  lazy = false,
  opts = {
    delay = 0,
  },
  config = function(_, opts)
    local which_key = require("which-key")

    which_key.setup(opts)

    -- Document existing key chains
    which_key.add({
      { "<leader>c", group = "[C]ode" },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>g", group = "[G]it" },
      { "<leader>p", group = "[P]lan" },
      { "<leader>r", group = "[R]ename" },
      { "<leader>o", group = "[O]pencode" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>f", group = "[F]iletree", mode = { "n" } },
      { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
    })
  end,
}
