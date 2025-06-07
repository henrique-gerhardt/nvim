local M = {}

function M.setup()
	local wk_ok, which_key = pcall(require, "which-key")

	local function map(mode, lhs, rhs, args)
		local desc = args.desc or ""
		local icon = args.icon
		local opts = args.opts or {}
		local wk_opts = { mode = mode }

		local map_opts = vim.tbl_extend("force", opts, { desc = desc })
		vim.keymap.set(mode, lhs, rhs, map_opts)

		if wk_ok then
			local spec_entry = { lhs, rhs, desc = desc }
			if icon then
				spec_entry.icon = icon
			end

			which_key.add({ spec_entry }, wk_opts)
		end
	end

	map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {
		desc = "Toggle file explorer",
		icon = { icon = "󰮫", hl = "TelescopePrompt", color = "blue" },
		opts = { silent = true },
	})

	map("n", "<leader>w", "<cmd>w<CR>", {
		desc = "Write File",
		icon = { icon = "", color = "green" },
	})

	map({ "n", "v" }, "<leader>y", '"*y', {
		desc = "Yank to clipboard",
		icon = { icon = "󰆏", color = "blue" },
	})

        map({ "n", "v" }, "<leader>F", function()
                require("conform").format({
                        lsp_fallback = true,
                        async = false,
                        timeout_ms = 500,
                })
        end, {
                desc = "Format file or range",
                icon = { icon = "󰝕", color = "orange" },
        })

        map({ "n", "v" }, "<leader>f", function()
                require("flash").jump()
        end, {
                desc = "Flash",
                icon = { icon = "󱐋", color = "yellow" },
        })

        map("n", "<leader>p", function()
                require("telescope.builtin").find_files()
        end, {
                desc = "Find files",
                icon = { icon = "", hl = "Search", color = "blue" },
        })
end

function M.get_cmp_mappings()
	local cmp = require("cmp")
	return {
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<esc>"] = cmp.mapping.abort(),
	}
end

return M
