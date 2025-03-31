local function get_repo_files_callback(variable_instance)
  -- We need access to vim functions and potentially utils
  local util = require("codecompanion.utils") -- For vim.system, vim.notify etc.
  local log = require("codecompanion.utils.log") -- Optional: for logging

  -- Access the chat context via the passed variable_instance
  -- This gives us the buffer number relevant to the current chat interaction
  local current_buf = variable_instance.Chat.context.bufnr
  local filepath = vim.api.nvim_buf_get_name(current_buf)

  -- Error handling: Check if we have a file path
  if filepath == "" or filepath == nil then
    log:warn("Repo Variable Callback: Cannot determine file path for buffer %d.", current_buf)
    -- Return an error message string which will be added to the context
    return "Error: Could not determine the file path for the current buffer to find the repository."
  end

  -- Get the directory containing the current file
  local filedir = vim.fn.fnamemodify(filepath, ":p:h")

  -- 1. Find the root of the git repository
  --    Use '-C <dir>' to run git in the file's directory context
  local git_root_cmd = vim.system({ "git", "-C", filedir, "rev-parse", "--show-toplevel" }, {
    text = true, -- Capture output as string
    timeout = 5000, -- Add a timeout (milliseconds)
  })

  -- Check if the command was successful
  if git_root_cmd.code ~= 0 then
    local err = git_root_cmd.stderr or "Unknown error finding git root"
    log:warn("Repo Variable Callback: %s", err)
    if string.match(err, "not a git repository") then
      return "Context Error: The current file is not inside a Git repository."
    else
      return "Context Error: Failed to find git repository root. " .. vim.trim(err)
    end
  end
  local git_root = vim.trim(git_root_cmd.stdout) -- Get the root path, remove trailing newline

  -- 2. Run git ls-files from the repository root
  local ls_files_cmd = vim.system({ "git", "ls-files" }, {
    cwd = git_root, -- Run command from the git root directory
    text = true, -- Capture output as string
    timeout = 10000, -- Longer timeout for potentially large repos
  })

  -- Check if ls-files command was successful
  if ls_files_cmd.code ~= 0 then
    local err = ls_files_cmd.stderr or "Unknown error running git ls-files"
    log:warn("Repo Variable Callback: %s", err)
    return "Context Error: Failed to list files in the repository. " .. vim.trim(err)
  end

  local file_list = ls_files_cmd.stdout
  if file_list == "" then
    -- Log this, but provide context that no files were found
    log:info("Repo Variable Callback: No files found via 'git ls-files' in %s", git_root)
    file_list = "(No files found in git index)"
  end

  -- 3. Format the context string to be returned
  local context_header = "Context: Files tracked by Git in the current repository (" .. git_root .. "):\n---\n"
  local context_footer = "\n---" -- Optional footer
  local full_content = context_header .. file_list .. context_footer

  log:trace("Repo Variable Callback generated context:\n%s", full_content)

  return full_content -- Return the generated string
end

return get_repo_files_callback
