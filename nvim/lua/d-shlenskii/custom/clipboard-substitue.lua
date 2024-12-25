vim.keymap.set("n", "<leader>rw", function()
	return ":%s/<C-r><C-w>//gc<left><left><left>"
end, { expr = true, desc = "Rename Word (Window)" })

vim.keymap.set("n", "<leader>rW", function()
	return ":" .. vim.fn.line(".") .. "s/<C-r><C-w>//g<left><left>"
end, { expr = true, desc = "Rename Word (Line)" })

vim.keymap.set("n", "<leader>rc", function()
	local clipboard = vim.fn.getreg("*")
	return ":%s/" .. clipboard .. "//gc<left><left><left>"
end, { expr = true, desc = "Rename Word from the Clipboard (Window)" })

vim.keymap.set("n", "<leader>rC", function()
	local clipboard = vim.fn.getreg("*")
	return ":" .. vim.fn.line(".") .. "s/" .. clipboard .. "//g<left><left>"
end, { expr = true, desc = "Rename Word from the Clipboard (Line)" })
