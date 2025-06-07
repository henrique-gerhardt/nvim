local M = {}

function M.setup()
	local function organize_imports()
		local bufnr = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		if vim.tbl_isempty(clients) then
			return
		end

		local client = clients[1]
		local encoding = client.offset_encoding

		local params = vim.lsp.util.make_range_params(0, encoding)
		params.context = { only = { "source.organizeImports" } }

		local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 500)
		if not results then
			return
		end

		for _, res in pairs(results) do
			if res.result then
				for _, action in ipairs(res.result) do
					if action.edit then
						vim.lsp.util.apply_workspace_edit(action.edit, encoding)
					end
					if action.command then
						vim.lsp.buf.execute_command(action.command)
					end
				end
			end
		end
	end

        vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                        require("conform").format({
                                lsp_fallback = true,
                                async = false,
                                timeout_ms = 500,
                        })
                        organize_imports()
                end,
        })
end
return M
