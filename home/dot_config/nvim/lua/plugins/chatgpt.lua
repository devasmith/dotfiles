return {
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },

    config = function()
      local home = vim.fn.expand("$HOME")
      require("chatgpt").setup({
        api_key_cmd = "gpg --decrypt " .. home .. "/.openai-key.txt.gpg",

        openai_params = {
          model = "gpt-4.1-mini",
          max_completion_tokens = 1200,
        },
      })
    end,
  },
}
