return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()

    -- Helper function to create Anthropic adapter based on state
    function CreateAnthropicAdapter(thinking_enabled)
      local thinking_budget_max = 32000
      return require("codecompanion.adapters").extend("anthropic", {
        schema = {
          model = { default = "claude-sonnet-4-5" },
          extended_output = { default = thinking_enabled },
          extended_thinking = { default = thinking_enabled },
          thinking_budget = { default = thinking_enabled and thinking_budget_max or nil },
          max_tokens = {
            default = function()
              if thinking_enabled then
                return thinking_budget_max + 1000
              end
              return 8192
            end,
          },
        },
      })
    end

    -- Helper function to create Gemini adapter based on state
    function CreateGeminiAdapter(thinking_enabled, grounding_enabled)
      return require("codecompanion.adapters").extend("gemini", {
        handlers = {
          form_parameters = function(self, params, messages)
            if grounding_enabled then
              params = params or {}
              params.tools = { { google_search = vim.empty_dict() } }
              print(vim.inspect(params))
              print(vim.json.encode(params))
            end
            return params
          end,
        },
        schema = {
          model = {
            default = thinking_enabled and "gemini-2.5-pro-preview-05-06" or "gemini-2.5-flash-preview-04-17",
          },
        },
      })
    end

    local function CreateToggleCommand(command_name, feature_name, state_var_name, valid_adapters)
      vim.api.nvim_create_user_command(command_name, function()
        local util = require("codecompanion.utils")
        local chat = require("codecompanion").last_chat()

        if not chat then
          util.notify("CodeCompanion: Chat must be open to toggle " .. feature_name, vim.log.levels.ERROR)
          return
        end

        local bufnr = chat.bufnr
        local adapter_name = chat.adapter.name

        -- Check if adapter supports this feature
        if not valid_adapters[adapter_name] then
          local valid_adapter_names = {}
          for name, _ in pairs(valid_adapters) do
            table.insert(valid_adapter_names, name)
          end
          util.notify(
            "CodeCompanion: "
              .. feature_name
              .. " toggle is only available for "
              .. table.concat(valid_adapter_names, " or "),
            vim.log.levels.ERROR
          )
          return
        end

        -- Can add the following to the `init` function to avoid redundant initialization:
        --
        -- vim.api.nvim_create_autocmd("BufWinEnter", {
        --   pattern = "codecompanion://*", -- Adjust pattern if chat buffer names differ
        --   callback = function(args)
        --       -- Use a flag to initialize only once per buffer load
        --       if vim.b[args.buf].codecompanion_initialized == nil then
        --           vim.b[args.buf].codecompanion_thinking_enabled = false
        --           vim.b[args.buf].codecompanion_grounding_enabled = false
        --           vim.b[args.buf].codecompanion_initialized = true
        --           -- Optional: Log initialization for debugging
        --           -- vim.notify("Initialized CodeCompanion state for buffer " .. args.buf)
        --       end
        --   end,
        --   desc = "Initialize CodeCompanion buffer state",
        -- })
        --
        -- Ensure buffer variables are initialized (might be redundant with BufWinEnter but safe)
        if vim.b[bufnr].codecompanion_initialized == nil then
          vim.b[bufnr].codecompanion_thinking_enabled = adapter_name == "gemini" and true or false
          vim.b[bufnr].codecompanion_grounding_enabled = false
          vim.b[bufnr].codecompanion_initialized = true
        end

        -- Get current state from buffer variable, default to false
        local current_state = vim.b[bufnr][state_var_name] or false
        local new_state = not current_state
        vim.b[bufnr][state_var_name] = new_state -- Store new state in buffer variable

        -- Get potentially relevant states for adapter creation
        local thinking_state = vim.b[bufnr].codecompanion_thinking_enabled
        local grounding_state = vim.b[bufnr].codecompanion_grounding_enabled

        -- Recreate and assign the adapter based on the new state(s) for this buffer
        local new_adapter
        if adapter_name == "anthropic" then
          new_adapter = CreateAnthropicAdapter(thinking_state)
        elseif adapter_name == "gemini" then
          new_adapter = CreateGeminiAdapter(thinking_state, grounding_state)
        else
          -- Should not happen due to valid_adapters check, but good practice
          util.notify("CodeCompanion: Unexpected adapter type: " .. adapter_name, vim.log.levels.ERROR)
          return
        end

        chat.adapter = new_adapter

        -- Update chat internals
        util.fire("ChatAdapter", { bufnr = bufnr, adapter = require("codecompanion.adapters").make_safe(chat.adapter) })
        chat.ui.adapter = chat.adapter
        chat:apply_settings()

        local status = new_state and "enabled" or "disabled"
        util.notify(
          "CodeCompanion: "
            .. feature_name:sub(1, 1):upper()
            .. feature_name:sub(2)
            .. " "
            .. status
            .. " for buffer "
            .. bufnr,
          vim.log.levels.INFO
        )
      end, {})
    end

    -- Create the toggle commands using the helper
    CreateToggleCommand(
      "CodeCompanionToggleThinking",
      "thinking",
      "codecompanion_thinking_enabled",
      { anthropic = true, gemini = true } -- Adapters supporting thinking toggle
    )
    CreateToggleCommand(
      "CodeCompanionToggleGrounding",
      "grounding",
      "codecompanion_grounding_enabled",
      { gemini = true } -- Adapters supporting grounding toggle
    )

    --
    -- Set Up keymaps for adding buffer and file to the codecompanion buffer
    -- vim.keymap.set("n", "<leader>cb", function()
    --   -- Enter insert mode
    --   vim.cmd("startinsert")

    --   -- Insert "/buffer" at cursor position
    --   vim.api.nvim_put({ "/buffer" }, "c", true, false)

    --   vim.defer_fn(function()
    --     local cmp = require("cmp")
    --     cmp.complete({})
    --     cmp.confirm({ select = true })
    --   end, 10)
    -- end, { desc = "[C]hat [B]uffer command" })

    -- vim.keymap.set("n", "<leader>cf", function()
    --   -- Enter insert mode
    --   vim.cmd("startinsert")

    --   -- Insert "/buffer" at cursor position
    --   vim.api.nvim_put({ "/file" }, "c", true, false)

    --   vim.defer_fn(function()
    --     local cmp = require("cmp")
    --     cmp.complete({})
    --     cmp.confirm({ select = true })
    --   end, 10)
    -- end, { desc = "[C]hat [F]ile command" })
  end,
  keys = {
    { "<leader>ca", "<CMD>CodeCompanionActions<CR>", desc = "[C]ode Companion [A]ctions", silent = true },
    {
      "<leader>cv",
      "<CMD>CodeCompanionChat Toggle<CR>",
      desc = "[C]ode Companion [V]ertical Split Chat",
      silent = true,
    },
    { "<leader>cc", "<CMD>CodeCompanion<CR>", desc = "[C]ode [C]ompanion", silent = true },
    {
      "<leader>ct",
      "<CMD>CodeCompanionToggleThinking<CR>",
      desc = "[C]ode Companion Toggle [T]hinking",
      silent = true,
    },
    {
      "<leader>cg",
      "<CMD>CodeCompanionToggleGrounding<CR>",
      desc = "[C]ode Companion Toggle [G]rounding",
      silent = true,
    },
    -- { "ga", "<cmd>CodeCompanionChat Add<cr>", noremap = true, silent = true, desc = "[C]ode Companion [A]dd" },
  },
  opts = {
    prompt_library = {
      ["claude.ai"] = {
        strategy = "chat",
        description = "The system prompt for Claude.ai",
        opts = {
          index = 1,
          is_default = true,
          auto_submit = false,
          user_prompt = false,
        },
        prompts = {
          {
            role = "system",
            content = function(context)
              local file_path = vim.fn.stdpath("config") .. "/lua/plugins/codecompanion/claude-system-prompt.txt"
              local lines = vim.fn.readfile(file_path)
              local content_str = table.concat(lines, "\n")
              return content_str:gsub("{{currentDateTime}}", vim.fn.strftime("%Y-%m-%d")) .. "\n\n---\n"
            end,
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = "",
          },
        },
      },
    },
    adapters = {
      anthropic = function()
        return CreateAnthropicAdapter(false)
      end,
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          schema = {
            model = {
              default = "o3-mini-2025-01-31",
            },
            resoning_effort = {
              default = "high",
            },
          },
        })
      end,
      gemini = function()
        return CreateGeminiAdapter(true, false)
      end,
    },
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = "anthropic",
        -- adapter = "gemini",
        -- adapter = "openai",
        slash_commands = {
          ["file"] = {
            callback = "strategies.chat.slash_commands.file",
            description = "Select a file using Telescope",
            opts = {
              provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
              contains_code = true,
            },
          },
          ["buffer"] = {
            callback = "strategies.chat.slash_commands.buffer",
            description = "Select a buffer using Telescope",
            opts = {
              provider = "telescope",
              contains_code = true,
            },
          },
        },
        variables = {
          ["repo"] = {
            ---@return string|fun(): nil
            callback = function(variable_instance)
              return require("plugins.codecompanion.repo-callback")(variable_instance)
            end,
            description = "All files in the current repository",
            opts = {
              contains_code = true,
            },
          },
        },
      },
      inline = {
        adapter = "gemini",
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
    },
    display = {
      action_palate = {
        provider = "telescope",
      },
    },
    log_level = "TRACE",
  },
}
