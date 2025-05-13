local keymap = require("config.keymap")

return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function(_, opts)
      -- Highlight ghost text (LazyVim default)
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      -- Base configuration
      opts.completion = {
        completeopt = "menu,menuone,noinsert",
      }
      opts.mapping = require("cmp").mapping.preset.insert(keymap.get_cmp_mappings())
      opts.preselect = require("cmp").PreselectMode.Item

      -- Define sources: LSP, buffer, path, etc.
      opts.sources = {
        { name = "nvim_lsp" },
        { name = "buffer", option = {
            get_bufnrs = function() return vim.api.nvim_list_bufs() end
          }
        },
        { name = "path" },
      }

      return opts
    end,
}

