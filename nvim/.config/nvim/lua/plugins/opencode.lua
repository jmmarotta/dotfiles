return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = function(_, opts)
        opts.input = opts.input or { enabled = true }
        opts.picker = opts.picker or { enabled = true }
        opts.picker.actions = opts.picker.actions or {}
        opts.picker.actions.opencode_send = function(...)
          return require("opencode").snacks_picker_send(...)
        end
        opts.picker.win = opts.picker.win or {}
        opts.picker.win.input = opts.picker.win.input or {}
        opts.picker.win.input.keys = opts.picker.win.input.keys or {}
        opts.picker.win.input.keys["<a-a>"] = { "opencode_send", mode = { "n", "i" } }
      end,
    },
  },
  init = function()
    vim.g.opencode_opts = {}
    vim.o.autoread = true
  end,
  config = function()
    local opencode_cmd = "opencode --port"
    local terminal_opts = {
      win = {
        position = "right",
        enter = false,
        width = 0.45,
        on_win = function(win)
          require("opencode.terminal").setup(win.win)
        end,
      },
    }
    local config = require("opencode.config")

    config.opts.server = vim.tbl_extend("force", config.opts.server or {}, {
      start = function()
        require("snacks.terminal").open(opencode_cmd, terminal_opts)
      end,
      stop = function()
        local terminal = require("snacks.terminal").get(opencode_cmd, terminal_opts)
        if terminal then
          terminal:close()
        end
      end,
      toggle = function()
        require("snacks.terminal").toggle(opencode_cmd, terminal_opts)
      end,
    })
  end,
  keys = {
    {
      "<leader>oo",
      function()
        require("opencode").toggle()
      end,
      desc = "[O]pencode Toggle",
    },
    {
      "<leader>oa",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "[O]pencode [A]sk",
    },
    {
      "<leader>os",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "[O]pencode [S]elect",
    },
  },
}
