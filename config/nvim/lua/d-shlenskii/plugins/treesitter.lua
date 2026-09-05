return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		modules = {},
		auto_install = true,
		-- needs the tree-sitter CLI and node to be generated from grammar
		ignore_install = { "latex" },
		sync_install = false,
		highlight = {
			enable = true,
		},
		indent = { enable = true },
		autotag = {
			enable = true,
		},
		ensure_installed = {
			"json",
			"yaml",
			"html",
			"toml",
			"markdown",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"c",
			"cpp",
			"cuda",
			"rust",
			"go",
			"gomod",
			"make",
			"cmake",
			"python",
			"proto",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
