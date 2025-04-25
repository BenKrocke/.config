vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })
vim.keymap.set("n", "<leader>lr", function()
	vim.cmd("luafile %")
end, { desc = "Run current Lua file" })
