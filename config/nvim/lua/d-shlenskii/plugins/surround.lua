return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	lazy = true,
	-- v4 dropped the `keymaps` option: the plugin binds its defaults from
	-- plugin/nvim-surround.lua, so the opt-outs have to be set before it loads.
	init = function()
		vim.g.nvim_surround_no_normal_mappings = true
		vim.g.nvim_surround_no_visual_mappings = true
	end,
	config = function()
		require("nvim-surround").setup()

		vim.keymap.set("n", "sa", "<Plug>(nvim-surround-normal)", {
			desc = "Add a surrounding pair around a motion",
		})
		vim.keymap.set("n", "sd", "<Plug>(nvim-surround-delete)", {
			desc = "Delete a surrounding pair",
		})
		vim.keymap.set("n", "sc", "<Plug>(nvim-surround-change)", {
			desc = "Change a surrounding pair",
		})
		vim.keymap.set("x", "sa", "<Plug>(nvim-surround-visual)", {
			desc = "Add a surrounding pair around a visual selection",
		})
	end,
}
