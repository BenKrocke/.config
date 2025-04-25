return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		telescope.setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>pf", builtin.git_files, { desc = "Find git files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
		vim.keymap.set("n", "<leader>lh", function()
			require("telescope.builtin").help_tags({ search = "lua" })
		end, { desc = "Search Lua help tags" })
	end,
}
