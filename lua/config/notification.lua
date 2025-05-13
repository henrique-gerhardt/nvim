local M = {}

function M.setup()
	-- Notificação no save
	vim.api.nvim_create_augroup("SaveNotify", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = "SaveNotify",
		pattern = "*",
		callback = function(event)
			local name = vim.fn.fnamemodify(event.file, ":t")
			vim.schedule(function()
				vim.notify("Arquivo salvo: " .. name, "info", {
					title = "Salvar",
					icon = "",
				})
			end)
		end,
	})

	-- Notificação no yank
	vim.api.nvim_create_augroup("YankNotify", { clear = true })
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = "YankNotify",
		callback = function(event)
			vim.schedule(function()
				local text = nil
				if event.regcontents then
					text = table.concat(event.regcontents, event.regtype or "")
				else
					local reg = (event.regname ~= "" and event.regname) or '"'
					text = vim.fn.getreg(reg)
				end

				local snippet = (#text > 30) and (text:sub(1, 30) .. "…") or text

				vim.notify(snippet, "info", {
					title = "Yank",
					icon = "󰆏",
				})
			end)
		end,
	})
end

return M
