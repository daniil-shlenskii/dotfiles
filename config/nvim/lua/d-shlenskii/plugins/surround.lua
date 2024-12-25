return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	lazy = true,
	config = function()
		local surround = require("nvim-surround")

		surround.setup({
			keymaps = {
				normal = "sa",
				delete = "sd",
				change = "sc",
				visual = "sa",
			},
		})
	end,
}
