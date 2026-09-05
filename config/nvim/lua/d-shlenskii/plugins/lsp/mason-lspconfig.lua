return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"basedpyright",
			},
			automatic_installation = true,
		})
	end,
}
