return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	opts = {},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "require" },
					},
				},
			},
		})
		lspconfig.pyright.setup({ capabilities = capabilities })
		lspconfig.bashls.setup({ capabilities = capabilities })

		vim.diagnostic.config({
			virtual_text = { current_line = true },
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
		})
	end,
}

--TODO: SETUP LSP SERVERS FOR PYTHON AND BASH.
