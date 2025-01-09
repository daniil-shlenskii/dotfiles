vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights." })

-- cursor movement
keymap.set({ "n", "v", "o" }, "L", "e", { noremap = true, desc = "Move cursor to the end of a next word." })
keymap.set({ "n", "v", "o" }, "H", "b", { noremap = true, desc = "Move cursor to the start of a word." })
keymap.set({ "n", "v", "o" }, "<leader>h", "0", { noremap = true, desc = "Move cursor to the start of a line." })
keymap.set({ "n", "v", "o" }, "<leader>l", "$", { noremap = true, desc = "Move cursor to the end of a line." })
keymap.set({ "n", "v", "o" }, "w", "iw", { noremap = true, desc = "Move cursor to the end of a line." })

keymap.set({ "n", "v", "o" }, "<leader>k", "gg", { noremap = true, desc = "Move cursor the first line." })
keymap.set({ "n", "v", "o" }, "<leader>j", "G", { noremap = true, desc = "Move cursor the first line." })

-- deletion
keymap.set("n", "dL", "dw", {
	noremap = true,
	desc = "Delete the characters of the word from the cursor position to the start of the next word.",
})
keymap.set("n", "dH", "db", {
	noremap = true,
	desc = "Delete the characters of the word from the cursor position to the end of the previous word.",
})

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move cursor to the left window." })
keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move cursor to the right window." })
keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move cursor to the window below." })
keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move cursor to the window above." })
--
keymap.set("n", "<D-l>h", "<C-w>h", { desc = "Move cursor to the left window." })
keymap.set("n", "<D-l>l", "<C-w>l", { desc = "Move cursor to the right window." })
keymap.set("n", "<D-l>j", "<C-w>j", { desc = "Move cursor to the window below." })
keymap.set("n", "<D-l>k", "<C-w>k", { desc = "Move cursor to the window above." })

keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
