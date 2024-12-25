return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	event = "VeryLazy",
	enabled = true,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
						["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

						["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

						["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
						["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

						["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

						["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
						["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

						["am"] = {
							query = "@function.outer",
							desc = "Select outer part of a method/function definition",
						},
						["im"] = {
							query = "@function.inner",
							desc = "Select inner part of a method/function definition",
						},

						["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

						["a/"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
						["i/"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
						["<leader>n:"] = "@property.outer", -- swap object property with next
						["<leader>nm"] = "@function.outer", -- swap function with next
					},
					swap_previous = {
						["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
						["<leader>p:"] = "@property.outer", -- swap object property with prev
						["<leader>pm"] = "@function.outer", -- swap function with previous
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["<leader>fj"] = { query = "@function.outer", desc = "Next method/function def start" },
						["<leader>cj"] = { query = "@class.outer", desc = "Next class start" },
						["<leader>ij"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["<leader>lj"] = { query = "@loop.outer", desc = "Next loop start" },
						["<leader>bj"] = { query = "@block.outer", desc = "Next block start" },

						-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
						-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
						["<leader>sj"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["<leader>zj"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
					goto_next_end = {
						["<leader>Fj"] = { query = "@function.outer", desc = "Next method/function def end" },
						["<leader>Cj"] = { query = "@class.outer", desc = "Next class end" },
						["<leader>Ij"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["<leader>Lj"] = { query = "@loop.outer", desc = "Next loop end" },
						["<leader>Bj"] = { query = "@block.outer", desc = "Next block end" },
					},
					goto_previous_start = {
						["<leader>fk"] = { query = "@function.outer", desc = "Prev method/function def start" },
						["<leader>ck"] = { query = "@class.outer", desc = "Prev class start" },
						["<leader>ik"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["<leader>lk"] = { query = "@loop.outer", desc = "Prev loop start" },
						["<leader>bk"] = { query = "@block.outer", desc = "Prev block start" },
					},
					goto_previous_end = {
						["<leader>Fk"] = { query = "@function.outer", desc = "Prev method/function def end" },
						["<leader>Ck"] = { query = "@class.outer", desc = "Prev class end" },
						["<leader>Ik"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["<leader>Lk"] = { query = "@loop.outer", desc = "Prev loop end" },
						["<leader>Bk"] = { query = "@block.outer", desc = "Prev block end" },
					},
				},
			},
		})

		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
		vim.keymap.set({ "n", "x", "o" }, "<C-j>", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, "<C-k>", ts_repeat_move.repeat_last_move_previous)

		-- Repeat movement with ; and ,
		-- ensure ; goes forward and , goes backward regardless of the last direction
	end,
}
