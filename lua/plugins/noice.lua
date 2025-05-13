local function hide_msg(pattern)
	return {
		filter = { event = "msg_show", find = pattern },
		opts = { skip = true },
	}
end

local function hide_notify(pattern)
	return {
		filter = { event = "notify", find = pattern },
		opts = { skip = true },
	}
end

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			-- desliga o cmdline nativo
			cmdline = {
				enabled = true, -- ativa o módulo de cmdline do noice
				view = "cmdline_popup", -- usa popup em vez do bottom
				opts = {
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					position = {
						row = -2, -- -1 seria sobre a statusline, -2 fica logo acima
						col = "50%",
					},
					size = {
						width = 60, -- ajuste conforme seu gosto
					},
				},
			},

			-- desliga o bottom-search e usa popup para busca
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},

			-- presets úteis
			presets = {
				bottom_search = false, -- não usar barra inferior para search
				command_palette = true, -- popup tipo palette para comandos
				long_message_to_split = true, -- splits para mensagens longas
			},

			views = {
				cmdline_popup = {
					border = { style = "rounded", padding = { 1, 2 } },
					win_options = {
						winblend = 10,
					},
				},
			},
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
			},
			routes = {
				hide_msg("yanked"),
				hide_msg("fewer lines"),
				hide_msg("line less"),
				hide_msg("deleted"),
				hide_notify("No code actions available"),
				hide_notify(
					"warning: multiple different client offset_encodings detected for buffer, this is not supported yet"
				),
			},
		})
	end,
}
