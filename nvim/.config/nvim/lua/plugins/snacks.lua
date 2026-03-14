return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        bo = {
          buflisted = true,
        },
        keys = {
          term_normal = {
            "<Esc><Esc>",
            "<C-\\><C-n>",
            mode = "t",
            desc = "Double escape to normal mode",
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "[S]earch [H]elp",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "[S]earch [K]eymaps",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.pickers()
      end,
      desc = "[S]earch [S]elect Picker",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "[S]earch [D]iagnostics",
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.resume()
      end,
      desc = "[S]earch [R]esume",
    },
    {
      "<leader>s.",
      function()
        Snacks.picker.recent()
      end,
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      "<leader><leader>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "[ ] Find existing buffers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.lines()
      end,
      desc = "[/] Fuzzily search in current buffer",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "[S]earch [/] in Open Files",
    },
    {
      "<leader>sn",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "[S]earch [N]eovim files",
    },
  },
}
