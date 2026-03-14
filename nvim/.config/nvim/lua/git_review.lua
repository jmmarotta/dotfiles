local M = {}

local REVIEWABLE_DIFF_FILTER = "ACMR"

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "Git Review" })
end

local function git_lines(cwd, args)
  local command = vim.list_extend({ "git", "-C", cwd }, args)
  local result = vim.system(command, { text = true }):wait()

  if result.code ~= 0 then
    local error_output = vim.trim(result.stderr or result.stdout or "git command failed")
    return nil, error_output
  end

  local output = vim.trim(result.stdout or "")
  if output == "" then
    return {}
  end

  return vim.split(output, "\n", { plain = true, trimempty = true })
end

local function git_root(cwd)
  local lines, err = git_lines(cwd, { "rev-parse", "--show-toplevel" })
  if not lines then
    return nil, err
  end

  return lines[1]
end

local function unique_sorted(paths)
  local seen = {}
  local unique = {}

  for _, path in ipairs(paths) do
    if path ~= "" and not seen[path] then
      seen[path] = true
      unique[#unique + 1] = path
    end
  end

  table.sort(unique)
  return unique
end

local function collect_staged(root)
  return git_lines(root, { "diff", "--cached", "--name-only", "--diff-filter=" .. REVIEWABLE_DIFF_FILTER })
end

local function collect_unstaged(root)
  local tracked, tracked_err = git_lines(root, { "diff", "--name-only", "--diff-filter=" .. REVIEWABLE_DIFF_FILTER })
  if not tracked then
    return nil, tracked_err
  end

  local untracked, untracked_err = git_lines(root, { "ls-files", "--others", "--exclude-standard" })
  if not untracked then
    return nil, untracked_err
  end

  return unique_sorted(vim.list_extend(tracked, untracked))
end

local function existing_paths(root, relative_paths)
  local paths = {}
  local skipped = 0

  for _, relative_path in ipairs(relative_paths) do
    local absolute_path = vim.fs.joinpath(root, relative_path)
    if vim.uv.fs_stat(absolute_path) then
      paths[#paths + 1] = absolute_path
    else
      skipped = skipped + 1
    end
  end

  return paths, skipped
end

local function skipped_suffix(skipped)
  if skipped == 0 then
    return ""
  end

  return ("; skipped %d missing or deleted"):format(skipped)
end

local function open_review_buffers(label, relative_paths, root)
  local paths, skipped = existing_paths(root, relative_paths)

  if #paths == 0 then
    notify(("No %s files to open%s"):format(label, skipped_suffix(skipped)))
    return
  end

  vim.cmd(("hide edit %s"):format(vim.fn.fnameescape(paths[1])))

  for index = 2, #paths do
    local buffer = vim.fn.bufadd(paths[index])
    vim.bo[buffer].buflisted = true
  end

  notify(("Opened %d %s file%s in buffers%s"):format(#paths, label, #paths == 1 and "" or "s", skipped_suffix(skipped)))
end

local function open_changes(label, collector)
  local cwd = vim.fn.getcwd()
  local root, root_err = git_root(cwd)
  if not root then
    notify(root_err, vim.log.levels.ERROR)
    return
  end

  local relative_paths, collect_err = collector(root)
  if not relative_paths then
    notify(collect_err, vim.log.levels.ERROR)
    return
  end

  open_review_buffers(label, relative_paths, root)
end

function M.open_unstaged()
  open_changes("unstaged", collect_unstaged)
end

function M.open_staged()
  open_changes("staged", collect_staged)
end

function M.setup()
  vim.api.nvim_create_user_command("GitReviewUnstaged", M.open_unstaged, { desc = "Open unstaged git files in buffers" })
  vim.api.nvim_create_user_command("GitReviewStaged", M.open_staged, { desc = "Open staged git files in buffers" })

  vim.keymap.set("n", "<leader>gu", M.open_unstaged, { desc = "[G]it Review [U]nstaged" })
  vim.keymap.set("n", "<leader>gs", M.open_staged, { desc = "[G]it Review [S]taged" })
end

return M
