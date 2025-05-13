return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    require("which-key").setup({
      preset = false,

      win = {
        row        = vim.o.lines - 28,
        no_overlap = true,
        width   = 60,
        col     = math.floor(vim.o.columns),
        padding = { 1, 1 },
        border  = "single",
      },

      layout = {
        width   = { min = 10, max = 30 },
        spacing = 2,
      },
    })

  end,
}
