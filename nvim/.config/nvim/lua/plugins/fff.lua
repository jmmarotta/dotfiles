return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  lazy = false,
  opts = {
    lazy_sync = true,
    prompt = "> ",
    hl = {
      normal = "NormalFloat",
    },
  },
  keys = {
    {
      "<leader>sf",
      function()
        require("fff").find_files()
      end,
      desc = "[S]earch [F]iles",
    },
    {
      "<leader>sg",
      function()
        require("fff").live_grep()
      end,
      desc = "[S]earch by [G]rep",
    },
    {
      "<leader>sw",
      function()
        require("fff").live_grep({ query = vim.fn.expand("<cword>") })
      end,
      desc = "[S]earch current [W]ord",
    },
  },
}
