local function picker(method, opts)
  return function()
    require("snacks").picker[method](opts)
  end
end

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
      picker("help"),
      desc = "[S]earch [H]elp",
    },
    {
      "<leader>sk",
      picker("keymaps"),
      desc = "[S]earch [K]eymaps",
    },
    {
      "<leader>ss",
      picker("pickers"),
      desc = "[S]earch [S]elect Picker",
    },
    {
      "<leader>sd",
      picker("diagnostics"),
      desc = "[S]earch [D]iagnostics",
    },
    {
      "<leader>sr",
      picker("resume"),
      desc = "[S]earch [R]esume",
    },
    {
      "<leader>s.",
      picker("recent"),
      desc = '[S]earch Recent Files ("." for repeat)',
    },
    {
      "<leader><leader>",
      picker("buffers"),
      desc = "[ ] Find existing buffers",
    },
    {
      "<leader>/",
      picker("lines"),
      desc = "[/] Fuzzily search in current buffer",
    },
    {
      "<leader>s/",
      picker("grep_buffers"),
      desc = "[S]earch [/] in Open Files",
    },
    {
      "<leader>sn",
      picker("files", { cwd = vim.fn.stdpath("config") }),
      desc = "[S]earch [N]eovim files",
    },
  },
}
