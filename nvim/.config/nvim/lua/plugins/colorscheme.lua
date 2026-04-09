return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local function detect_system_background()
        if vim.fn.has("macunix") == 0 then
          return vim.o.background
        end
        vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
        return vim.v.shell_error == 0 and "dark" or "light"
      end

      -- setup must run before loading the colorscheme so that
      -- the background -> theme mapping (wave/lotus) is registered
      require("kanagawa").setup({
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        background = {
          dark = "wave",
          light = "lotus",
        },
        colors = {
          theme = {
            all = {
              ui = { bg_gutter = "none" },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          local makeDiagnosticColor = function(color)
            local c = require("kanagawa.lib.color")
            return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
          end

          return {
            -- Tint background of diagnostic messages with their foreground color
            DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
            DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
            DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
            DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
            -- Dark completion (popup) menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
            -- Floats: one step darker than editor bg, border invisible
            NormalFloat = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            FloatBorder = { fg = theme.ui.special, bg = theme.ui.bg_m1 },
            FloatTitle = { fg = theme.ui.special, bg = theme.ui.bg_m1, bold = true },
          }
        end,
      })

      -- set vim.o.background from macOS appearance, then load kanagawa;
      -- kanagawa will select wave or lotus based on the background value
      vim.o.background = detect_system_background()
      vim.cmd.colorscheme("kanagawa")

      -- re-sync on focus so switching macOS appearance updates the theme
      -- without restarting nvim
      local group = vim.api.nvim_create_augroup("kanagawa-system-appearance", { clear = true })
      vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
        group = group,
        callback = function()
          local bg = detect_system_background()
          if vim.o.background ~= bg then
            vim.o.background = bg
            vim.cmd.colorscheme("kanagawa")
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
