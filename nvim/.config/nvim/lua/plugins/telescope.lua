return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    {
      "nvim-tree/nvim-web-devicons",
      enabled = vim.g.have_nerd_font,
      config = function()
        require("nvim-web-devicons").setup()
      end,
    },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Select multiple files ]]

    local select_one_or_multi = function(prompt_bufnr)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()

      -- Get the picker name to identify CodeCompanion pickers
      local picker_type = picker.prompt_title or ""

      -- Check if this is a CodeCompanion picker by looking for keywords in the title
      local is_codecompanion = string.find(picker_type, "Select file%(s%)")
        or string.find(picker_type, "Select buffer%(s%)")

      -- Use default behavior for CodeCompanion pickers
      if is_codecompanion then
        require("telescope.actions").select_default(prompt_bufnr)
        return
      end

      -- Handle multi-selection for other pickers
      if not vim.tbl_isempty(multi) then
        require("telescope.actions").close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then
            -- if j.lnum ~= nil then
            --   vim.cmd(string.format("%s %s:%s", "edit", j.path, j.lnum))
            -- else
            --   vim.cmd(string.format("%s %s", "edit", j.path))
            -- end
            vim.cmd(string.format("%s %s", "edit", j.path))
          end
        end
      else
        require("telescope.actions").select_default(prompt_bufnr)
      end
    end

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local telescope = require("telescope")
    telescope.setup({
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        mappings = {
          -- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          i = {
            ["<CR>"] = select_one_or_multi,
            ["<C-h>"] = "which_key",
          },
        },
      },
      -- pickers = {
      --   buffers = {
      --     sort_mru = true,
      --     sort_lastused = true,
      --     show_all_buffers = true,
      --   },
      -- },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        live_grep_args = {
          auto_quoting = true,
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "buffers")
    pcall(telescope.load_extension, "live_grep_args")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    local extensions = require("telescope").extensions
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", function()
      builtin.find_files({
        hidden = true,
        no_ignore = false,
        file_ignore_patterns = {
          -- Version Control
          "^.git/",
          -- Dependencies
          "node_modules/",
          "^.npm/",
          "^vendor/",
          "^.bundle/",
          "^.cargo/",
          "^target/", -- Rust
          "^dist/",
          "^build/",
          "^.next/", -- Next.js
          "^.nuxt/", -- Nuxt.js
          "^venv/", -- Python
          "^.venv/",
          "^__pycache__/",
          "^.pytest_cache/",
          "^.sst/",
          -- IDE & Tools
          "^.vscode/",
          "^.idea/",
          "^.settings/",
          -- Logs & Caches
          "%.log$",
          "^.cache/",
          "%.swp$",
          "%.swo$",
          -- Build outputs
          "%.o$",
          "%.obj$",
          "%.dll$",
          "%.class$",
          "%.exe$",
        },
      })
    end, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    -- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    -- See `:help telescope-live-grep-args` for the live_grep_args extension used below
    vim.keymap.set("n", "<leader>sg", extensions.live_grep_args.live_grep_args, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
  end,
}
