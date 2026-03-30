return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter", -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    -- Document existing key chains
    require("which-key").add({
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
