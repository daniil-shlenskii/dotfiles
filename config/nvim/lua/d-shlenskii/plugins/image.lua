return {
	{
		"3rd/image.nvim",
		cond = function()
			return vim.env.ZELLIJ == nil
		end,
		build = false,
		opts = {
			backend = "kitty",
			kitty_method = "unicode-placeholders",
			processor = "magick_cli",
			hijack_file_patterns = { "*.png" },
		},
	},
	{
		"princejoogie/chafa.nvim",
		cond = function()
			return vim.env.ZELLIJ ~= nil
		end,
		init = function()
			local chafa_executable = vim.fn.exepath("chafa")
			if chafa_executable == "" then
				return
			end

			vim.env.NVIM_CHAFA_EXECUTABLE = chafa_executable
			vim.env.PATH = vim.fn.stdpath("config") .. "/bin:" .. vim.env.PATH
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"m00qek/baleia.nvim",
		},
		opts = {
			events = {
				update_on_nvim_resize = true,
			},
		},
	},
}
