return {

  { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        lua = { "luacheck" },
        python = { "ruff" },
        javascript = { "oxlint" },
        javascriptreact = { "oxlint" },
        typescript = { "oxlint" },
        typescriptreact = { "oxlint" },
        go = { "golangcilint" },
        terraform = { "tflint" },
      }

      local function matches_pattern(path, pattern)
        return path:match(pattern) ~= nil
      end

      local function is_github_workflow(path)
        return matches_pattern(path, "/%.github/workflows/.*%.ya?ml$")
      end

      local function is_docker_compose(path)
        return matches_pattern(path, "/docker%-compose%.ya?ml$") or matches_pattern(path, "/compose%.ya?ml$")
      end

      local function linters_for_buffer(bufnr)
        local path = vim.api.nvim_buf_get_name(bufnr)
        local names = lint._resolve_linter_by_ft(vim.bo[bufnr].filetype)
        local seen = {}
        local result = {}

        for _, name in ipairs(names) do
          if not seen[name] then
            seen[name] = true
            result[#result + 1] = name
          end
        end

        if is_github_workflow(path) and not seen.actionlint then
          seen.actionlint = true
          result[#result + 1] = "actionlint"
        end

        if is_docker_compose(path) and not seen.yamllint then
          seen.yamllint = true
          result[#result + 1] = "yamllint"
        end

        return result
      end

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
        callback = function(args)
          local names = linters_for_buffer(args.buf)
          if #names > 0 then
            lint.try_lint(names)
          end
        end,
      })
    end,
  },
}
