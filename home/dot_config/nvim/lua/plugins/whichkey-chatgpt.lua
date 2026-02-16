return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local wk = require("which-key")

      wk.add({
        { "<leader>a", group = "AI", mode = { "n", "v" } },

        -- chat + edit
        { "<leader>ac", "<cmd>ChatGPT<CR>", desc = "ChatGPT", mode = "n" },
        { "<leader>ae", "<cmd>ChatGPTEditWithInstructions<CR>", desc = "Edit with instruction", mode = { "n", "v" } },

        -- actions
        { "<leader>aa", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
        { "<leader>ad", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
        { "<leader>af", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
        { "<leader>ag", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction", mode = { "n", "v" } },
        { "<leader>ak", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
        {
          "<leader>al",
          "<cmd>ChatGPTRun code_readability_analysis<CR>",
          desc = "Readability Analysis",
          mode = { "n", "v" },
        },
        { "<leader>ao", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
        { "<leader>as", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
        { "<leader>at", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
        { "<leader>ax", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
      })
    end,
  },
}
