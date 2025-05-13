return {
	{ "williamboman/mason.nvim", opts = {} },
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					rust = { "rustfmt" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					java = { "google-java-format" },
				},
			})
		end,
	},
	{ "zapling/mason-conform.nvim", opts = {} },
}
