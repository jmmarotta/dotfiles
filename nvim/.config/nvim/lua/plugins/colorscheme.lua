return {
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local base_opts = {
        italics = true,
        disable_italic_comments = false,
        sign_column_background = "none",
        ui_contrast = "low",
      }

      local function detect_system_background()
        if vim.fn.has("macunix") == 0 then
          return vim.o.background
        end
        vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
        return vim.v.shell_error == 0 and "dark" or "light"
      end

      local function apply_colorscheme(background)
        require("everforest").setup(vim.tbl_extend("force", base_opts, {
          background = background == "dark" and "medium" or "soft",
        }))
        vim.o.background = background
        vim.cmd.colorscheme("everforest")
      end

      apply_colorscheme(detect_system_background())

      local group = vim.api.nvim_create_augroup("everforest-system-appearance", { clear = true })
      vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
        group = group,
        callback = function()
          local bg = detect_system_background()
          if vim.o.background ~= bg then
            apply_colorscheme(bg)
          end
        end,
      })
    end,
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "rebelot/kanagawa.nvim",
    enabled = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    --   -- Load the colorscheme here.
    --   -- Like many other themes, this one has different styles, and you could load
    --   -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    --   -- vim.cmd.colorscheme 'tokyonight-night',

    --   -- You can configure highlights by doing something like:
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
    -- config = function()
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = false,
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("gruvbox").setup()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
