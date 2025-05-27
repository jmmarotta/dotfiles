return {

  { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- markdown = { "markdownlint" },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- Run tflint --init
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "terraform",
        callback = function()
          -- Try to find the project root
          local current_dir = vim.fn.expand("%:p:h")
          local root_dir = current_dir

          -- Look for .terraform or .git to identify project root
          while vim.fn.isdirectory(root_dir) == 1 do
            if vim.fn.isdirectory(root_dir .. "/.terraform") == 1 or vim.fn.isdirectory(root_dir .. "/.git") == 1 then
              break
            end

            local parent_dir = vim.fn.fnamemodify(root_dir, ":h")
            if parent_dir == root_dir then
              -- We've reached filesystem root
              root_dir = current_dir -- Fall back to current directory
              break
            end
            root_dir = parent_dir
          end

          -- Check if .tflint.hcl exists in the project root
          if vim.fn.filereadable(root_dir .. "/.tflint.hcl") == 0 then
            vim.fn.system("cd " .. root_dir .. " && tflint --init")
            print("TFLint initialized in " .. root_dir)
          end
        end,
      })
    end,
  },
}
