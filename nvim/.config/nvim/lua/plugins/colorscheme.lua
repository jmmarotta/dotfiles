return {
  {
    "sainnhe/gruvbox-material",
    lazy = false, -- Load immediately
    priority = 1000, -- Ensure it loads before other plugins
    config = function()
      -- Optional: customize the appearance (choose 'hard', 'medium', or 'soft')
      vim.g.gruvbox_material_background = "hard"
      -- Optional: you can also adjust other settings, e.g.,
      -- vim.g.gruvbox_material_foreground = "original"
      -- Set gruvbox-material as the active colorscheme
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd("colorscheme gruvbox-material")
    end,
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "neanias/everforest-nvim",
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
