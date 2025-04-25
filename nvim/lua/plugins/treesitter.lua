-- plugins/treesitter.lua
return {
	-- Treesitter for syntax highlighting and more
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- Install only essential parsers
			ensure_installed = {
				"lua", -- For Lua development
				"vim", -- For Neovim config files
				"vimdoc", -- For Neovim help docs
				"javascript", -- For Node.js and browser JS
				"typescript", -- Often used with React
				"tsx", -- React with TypeScript (TSX)
				"json", -- Common with Node/React configs
				"html", -- For React apps
				"css", -- For styling React apps
			},

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			-- Enable syntax highlighting
			highlight = {
				enable = true,
			},

			autotag = {
				enable = true,
			},

			-- Enable indentation
			indent = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
