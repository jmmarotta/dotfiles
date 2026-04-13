return {
  {
    "webhooked/kanso.nvim",
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

      require("kanso").setup({
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        background = {
          dark = "ink",
          light = "pearl",
        },
        colors = {
          palette = {
            -- Kanso Pearl background options:
            -- #F2F1EF stock Pearl, spread 3
            -- #F3F1ED near-neutral, spread 6
            -- #F3F1EB subtle warm paper, spread 8
            -- #F4F1EA light warm paper, spread 10
            -- #F5F1E8 gentle cream, spread 13
            -- #FFFCF0 Flexoki-style warm cream, spread 15
            pearlWhite0 = "#F4F1EA",
          },
          theme = {
            all = {
              ui = { bg_gutter = "none" },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          local makeDiagnosticColor = function(color)
            local c = require("kanso.lib.color")
            return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
          end

          return {
            -- Tint diagnostic virtual text with a faint version of its foreground color.
            DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
            DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
            DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
            DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

            -- Keep the completion popup darker and self-contained.
            Pmenu = { fg = theme.ui.pmenu.fg, bg = theme.ui.pmenu.bg },
            PmenuSel = { fg = theme.ui.pmenu.fg_sel, bg = theme.ui.pmenu.bg_sel },
            PmenuSbar = { bg = theme.ui.pmenu.bg_sbar },
            PmenuThumb = { bg = theme.ui.pmenu.bg_thumb },

            -- Match floating windows and titles to the popup surface.
            NormalFloat = { fg = theme.ui.float.fg, bg = theme.ui.float.bg },
            FloatBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.float.bg_border },
            FloatTitle = { fg = theme.ui.special, bg = theme.ui.float.bg, bold = true },
          }
        end,
      })

      vim.o.background = detect_system_background()
      vim.cmd.colorscheme("kanso")

      local group = vim.api.nvim_create_augroup("kanso-system-appearance", { clear = true })
      vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
        group = group,
        callback = function()
          local bg = detect_system_background()
          if vim.o.background ~= bg then
            vim.o.background = bg
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
