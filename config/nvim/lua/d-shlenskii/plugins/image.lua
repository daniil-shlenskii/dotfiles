return {
	"3rd/image.nvim",
	build = false,
	opts = {
		backend = "kitty",
		kitty_method = "unicode-placeholders",
		processor = "magick_cli",
		hijack_file_patterns = { "*.png" },
	},
}
