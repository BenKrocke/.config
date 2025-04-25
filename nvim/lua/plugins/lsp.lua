return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = { "lua_ls", "ts_ls", "tailwindcss" },
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								-- vim.api.nvim_get_runtime_file("", true),
								-- vim.fn.expand("~/.config/nvim/love-api"),
								"${3rd}/love2d/library",
							},
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
							keywordSnippet = "Replace",
							displayContext = 5,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			lspconfig.ts_ls.setup({
				-- Default settings work well, but you can customize if needed
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			})

			lspconfig.tailwindcss.setup({
				filetypes = {
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								"tw`([^`]*)", -- tw`...`
								'tw="([^"]*)', -- tw="..."
								'tw={"([^"}]*)', -- tw={"..."}
								'className="([^"]*)', -- className="..."
								'class="([^"]*)', -- class="..."
							},
						},
					},
				},
			})

			vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "Show hover documentation" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
			vim.keymap.set(
				"n",
				"<leader>d",
				vim.diagnostic.open_float,
				{ desc = "Show diagnostics for the current line" }
			)
			vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format document",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"typescript-language-server",
				"prettier",
				"eslint_d",
				"tailwindcss-language-server",
			},
			auto_update = true,
			run_on_start = true,
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = {
					{ name = "nvim_lsp" }, -- LSP source
					{ name = "buffer" }, -- Buffer completion
					{ name = "path" }, -- Path completion
				},
			})

			-- Ensure the LSP source is available
			require("cmp_nvim_lsp").setup()
		end,
	},
}
