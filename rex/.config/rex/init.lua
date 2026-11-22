-- Ctrl+Space consumes one tab or pane command, then returns to terminal input.
-- Escape, Ctrl+C, and a second Ctrl+Space cancel the prefix.
rex.mode("tmux", { exclusive = true })
rex.bind("ctrl+space", "client.mode.enter", { name = "tmux", once = true })
rex.bind("tmux/ctrl+c", "client.mode.exit")
rex.bind("tmux/ctrl+space", "client.mode.exit")

rex.bind("tmux/c", "client.tab.new")
rex.bind("tmux/n", "client.tab.next")
rex.bind("tmux/p", "client.tab.previous")
rex.bind("tmux/w", "pane.go_to") -- Search panes and tabs rather than showing a tab overview.
for index = 1, 9 do
  rex.bind("tmux/" .. index, "client.tab.goto", { index = index })
end
rex.bind("tmux/0", "client.tab.goto", { index = -1 }) -- Rightmost tab, like Ghostty's last_tab.

-- Use the physical keys for % and " on a US keyboard.
rex.bind("tmux/shift+5", "pane.split", { direction = "right" })
rex.bind("tmux/shift+'", "pane.split", { direction = "down" })
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("tmux/" .. key, "pane.focus." .. direction)
  -- Match Rex's arrow shortcuts: Option moves focus, Shift splits.
  rex.bind("cmd+alt+" .. key, "pane.focus." .. direction)
  rex.bind("cmd+shift+" .. key, "pane.split", { direction = direction })
  -- Rex moves the divider by a percentage of the split, not by pixels.
  rex.bind("tmux/shift+" .. key, "pane.resize", { direction = direction, amount = 15 })
end

rex.action{
  name = "three_panes",
  title = "Create Three Panes",
  run = function()
    -- Split the focused pane into one right pane and two stacked left panes.
    rex.client.queue("pane.split", { direction = "right" })
    rex.client.queue("pane.focus.left")
    rex.client.queue("pane.split", { direction = "down" })
  end,
}
rex.bind("tmux/shift+t", "three_panes")
rex.bind("tmux/z", "pane.zoom")
rex.bind("tmux/=", "pane.balance")
-- Match the app's normal Close command, which can act on a pane, tab, or window.
rex.bind("tmux/q", "client.close")
rex.bind("tmux/r", "client.config.reload")
rex.bind("ctrl+[", "pane.send_key", { key = "escape" })
rex.bind("cmd+u", "client.scroll.page_up")
rex.bind("cmd+d", "client.scroll.page_down")

-- Write the current pane's plain-text scrollback, including captures too large for one reply.
local function write_scrollback(file, ctx)
  local session_id = assert(ctx.session_id, "No active Rex session")
  local block_id = ctx.block_id
  if not block_id then
    local view = assert(rex.call("session.view", { session_id = session_id }))
    for _, window in ipairs(view.windows or {}) do
      if window.window_id == view.active_window_id then
        block_id = window.focused_block_id
        break
      end
    end
  end
  assert(block_id, "No focused terminal pane")

  local function terminal_call(method, args)
    return assert(rex.call("com.superlogical.terminal." .. method, {
      session_id = session_id, block_id = block_id, args = args,
    }))
  end

  local chunk_size = 512 * 1024
  local snapshot = terminal_call("format", {
    format = "text", trim = true, max_bytes = chunk_size,
  })
  assert(file:write(snapshot.content))
  if not snapshot.id or snapshot.eof then return end

  local offset = #snapshot.content
  repeat
    local page = terminal_call("blob_read", {
      id = snapshot.id, offset = offset, max_bytes = chunk_size,
    })
    assert(file:write(page.data))
    offset = offset + #page.data
  until page.eof
end

-- Keep the private snapshot on disk and copy only its pathname to the macOS clipboard.
rex.action{
  name = "copy_scrollback_path",
  title = "Copy Scrollback File Path",
  run = function(ctx)
    local temp_dir = (os.getenv("TMPDIR") or "/tmp"):gsub("/+$", "")
    local template = temp_dir .. "/rex-scrollback.XXXXXXXX"
    local temp = assert(rex.exec({ "/usr/bin/mktemp", template }))
    assert(temp.ok, temp.stderr)
    local path = temp.stdout:gsub("\n$", "")

    local file, open_error = io.open(path, "wb")
    if not file then
      os.remove(path)
      error(open_error, 0)
    end
    local written, write_error = pcall(write_scrollback, file, ctx)
    local closed, close_error = file:close()
    if not written or not closed then
      os.remove(path)
      error(write_error or close_error, 0)
    end

    local copy, copy_error = rex.exec({ "/usr/bin/pbcopy" }, { stdin = path })
    if not copy or not copy.ok then
      error("Saved scrollback at " .. path .. "; clipboard failed: " .. (copy_error or copy.stderr), 0)
    end
    return path
  end,
}
rex.bind("tmux/s", "copy_scrollback_path")
