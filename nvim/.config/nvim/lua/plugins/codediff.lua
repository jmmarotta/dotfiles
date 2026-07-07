-- VSCode-style diff viewer. This config adds width-aware layout selection on top
-- of codediff's two layouts:
--   * wide UI  -> "side-by-side"
--   * narrow UI -> "inline" (unified, same-buffer)
--
-- Two mechanisms cooperate:
--   1. Open-time: keymaps launch `:CodeDiff ... --inline|--side-by-side` chosen by
--      width. Uses only documented codediff flags.
--   2. Resize-time: open codediff tabs are tracked via the `CodeDiffOpen`/
--      `CodeDiffClose` User autocmds, and `VimResized` re-flows any tab whose
--      layout no longer matches the desired width bucket.
--
-- Caveats baked in:
--   * codediff exposes no public "set layout" API. The runtime switch uses the
--      internal `codediff.ui.view.toggle_layout`, isolated in `reflow_tab` below so
--      a breaking upstream change only affects mechanism 2. Mechanism 1 keeps
--      working regardless.
--   * `vim.o.columns` is the full Neovim UI width, not the launching split's width.
--      codediff renders in its own tab using the full width, so this matches.
--   * Conflict views are forced side-by-side by codediff; the resize handler skips
--      tabs it did not open in a togglable mode (tracked layout is nil for those).

local WIDE_MIN_COLUMNS = 180

-- Single home for the layout decision.
local function desired_layout()
  return vim.o.columns >= WIDE_MIN_COLUMNS and "side-by-side" or "inline"
end

local function layout_flag()
  return desired_layout() == "side-by-side" and "--side-by-side" or "--inline"
end

-- Open codediff with the width-appropriate layout. `args` is the part after
-- `:CodeDiff` (may be empty).
local function open_codediff(args)
  local command = vim.trim(("CodeDiff %s %s"):format(args or "", layout_flag()))
  vim.cmd(command)
end

-- Tracks codediff tabpages we may re-flow: tabpage handle -> last applied layout.
local tracked = {}

-- Sole point that touches codediff's internal layout toggle. Returns true if the
-- toggle was attempted, false if the internal API was unavailable.
local function reflow_tab(tabpage, target)
  local ok, view = pcall(require, "codediff.ui.view")
  if not ok or type(view.toggle_layout) ~= "function" then
    return false
  end

  -- toggle_layout only flips; we only call it when current != target, so a single
  -- toggle lands on the target.
  pcall(view.toggle_layout, tabpage)
  tracked[tabpage] = target
  return true
end

local function reflow_all()
  local target = desired_layout()

  for tabpage, current in pairs(tracked) do
    if not vim.api.nvim_tabpage_is_valid(tabpage) then
      tracked[tabpage] = nil
    elseif current ~= target then
      reflow_tab(tabpage, target)
    end
  end
end

local function setup_autolayout()
  local group = vim.api.nvim_create_augroup("codediff-autolayout", { clear = true })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "CodeDiffOpen",
    callback = function(event)
      local data = event.data or {}
      local tabpage = data.tabpage or vim.api.nvim_get_current_tabpage()

      -- codediff forces side-by-side for conflict views and ignores layout
      -- toggling there; do not track those so the resize handler leaves them be.
      if data.mode == "conflict" then
        return
      end

      tracked[tabpage] = desired_layout()
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "CodeDiffClose",
    callback = function(event)
      local data = event.data or {}
      local tabpage = data.tabpage
      if tabpage then
        tracked[tabpage] = nil
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    callback = reflow_all,
  })
end

return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    {
      "<leader>gd",
      function()
        open_codediff("")
      end,
      desc = "[G]it [D]iff (explorer)",
    },
    {
      "<leader>gD",
      function()
        open_codediff("main...")
      end,
      desc = "[G]it [D]iff vs merge-base of main",
    },
    {
      "<leader>gh",
      function()
        open_codediff("history %")
      end,
      desc = "[G]it File [H]istory",
    },
    {
      "<leader>gH",
      function()
        open_codediff("history")
      end,
      desc = "[G]it Branch [H]istory",
    },
  },
  opts = {
    diff = {
      -- Open-time flags override this per invocation; kept as a sane fallback for
      -- any `:CodeDiff` run without a flag.
      layout = "side-by-side",
    },
    explorer = {
      hidden = false,
      view_mode = "tree",
      initial_focus = "explorer",
    },
    keymaps = {
      view = {
        toggle_stage = "s",
      },
    },
  },
  config = function(_, opts)
    require("codediff").setup(opts)
    setup_autolayout()
  end,
}
