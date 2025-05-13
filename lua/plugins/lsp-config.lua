vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
		},
	},
})

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local servers = {
			"lua_ls",
			"ts_ls",
			-- "jdtls",
		}

		require("mason").setup()

		local on_attach = function(client, bufnr) end
		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,

				--[[
      ["jdtls"] = function()
        local jdtls = require("jdtls")
        local home = vim.env.HOME

        local bundles = {}
        vim.list_extend(bundles, vim.split(
          vim.fn.glob(home
            .. "/.local/share/nvim/mason/packages/java-debug/com.microsoft.java.debug.plugin/target/*.jar"
          ), "\n"
        ))
        vim.list_extend(bundles, vim.split(
          vim.fn.glob(home
            .. "/.local/share/nvim/mason/packages/vscode-java-test/com.microsoft.java.test.plugin/target/*.jar"
          ), "\n"
        ))

        jdtls.start_or_attach({
          cmd = { "java", "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-jar",
                  vim.fn.glob(home
                    .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
                  ), "--configuration",
                  home .. "/.local/share/nvim/mason/packages/jdtls/config_linux"
          },
          root_dir = require("jdtls.setup").find_root({ "pom.xml", "build.gradle", ".git" }),
          on_attach = on_attach,
          capabilities = capabilities,
          init_options = { bundles = bundles },
        })
      end, ]]
				--
			},
		})
	end,
}
