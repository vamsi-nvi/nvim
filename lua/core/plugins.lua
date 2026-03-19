local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{ "rose-pine/neovim" },
	{ "folke/tokyonight.nvim" },
	{ "loctvl842/monokai-pro.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		config = function()
			local parsers = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"go",
				"rust",
			}
			require("nvim-treesitter").install(parsers)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					if not vim.treesitter.language.add(language) then
						return
					end
					vim.treesitter.start(buf, language)

					-- enables treesitter based folds
					-- for more info on folds see `:help folds`
					-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					-- vim.wo.foldmethod = "expr"

					-- enables treesitter based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
		opts = { default = true, strict = true },
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			render = "virtual",
			virtual_symbol_position = "inline",
			enable_tailwind = true,
		},
	},

	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.tabline").setup()
			require("mini.statusline").setup({
				content = {
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						mode = mode:sub(1, 1)
						local git = MiniStatusline.section_git({ trunc_width = 75 })
						local diff = MiniStatusline.section_diff({ trunc_width = 75 })
						local filename = MiniStatusline.section_filename({ trunc_width = 140 })
						filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
						local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
						local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
						local location = "%2l:%-2v"
						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diff } },
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=",
							{ hl = "MiniStatuslineDevinfo", strings = { diagnostics, lsp } },
							{ hl = mode_hl, strings = { location } },
						})
					end,
				},
				use_icons = true,
				set_vim_settings = true,
			})
		end,
	},

	-- ========================================================================
	-- Snacks (picker, explorer, notifier, etc.)
	-- ========================================================================
	{
		"folke/snacks.nvim",
		priority = 1001,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = false },
			dashboard = {
				enabled = true,
				preset = {
					header = [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠉⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠋⠉⠀⠀⠀⠀⠀⠄⠒⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⢀⣀⠀⠀⠐⠆⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⢀⢠⣿⣿⠀⠀⡎⠂⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢀⢘⢸⣿⣿⠀⠀⡄⡄⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠈⠛⠨⣿⣿⠀⠀⣟⡄⠘⣿⣿⣿⣿⡿⠿⠛⠋⠉⢁⠀⠀
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠇⠀⠀⠁⡐⢿⣿⠀⠀⣶⠆⡀⠈⠉⠉⠁⠀⠀⠐⠁⠀⠀⢀⠀
⠶⢿⣿⠿⣿⣿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⠛⠛⠉⠉⢀⣀⣀⠰⠾⡌⠄⠀⣀⣨⠴⡤⠒⠓⠀⠄⢒⢶⡐⡦⠒⠀⡈⠙⠉⠀
⠀⠀⠉⠉⠈⠈⠉⠉⠁⠀⠀⢈⣀⣀⣈⣠⡤⠤⠂⠀⠲⠚⣁⣀⠀⡀⣀⢀⣠⠖⠞⠈⠉⠁⠀⠄⠀⠤⠤⣶⣿⠿⢷⡄⠐⠐⠈⠁⠈⠀
⣠⣤⣶⣶⣿⣿⣿⣷⡶⡟⡻⠛⠋⠀⠈⠉⠈⢀⣌⠡⠥⠠⠈⠉⠅⠛⢉⠀⠀⠀⢀⠀⢀⣀⣤⠐⠛⠛⢁⣀⡀⡤⡀⠀⠠⠀⠀⠀⠀⠀
      ]],
				},
			},
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
			picker = {
				enabled = true,
				sources = {
					explorer = {
						hidden = true,
						ignored = true,
						layout = { layout = { width = 30 } },
					},
				},
			},
		},
	},

	{
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {},
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- ========================================================================
	-- LSP
	-- ========================================================================
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = { enabled = true, spacing = 4, prefix = " ■" },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", function()
						Snacks.picker.lsp_definitions()
					end, "Goto definition")
					map("gr", function()
						Snacks.picker.lsp_references()
					end, "Goto references")
					map("gi", function()
						Snacks.picker.lsp_implementations()
					end, "Goto implementation")
					map("gy", function()
						Snacks.picker.lsp_type_definitions()
					end, "Goto type definition")
					map("gD", vim.lsp.buf.declaration, "Goto declaration")
					map("<leader>ds", function()
						Snacks.picker.lsp_symbols()
					end, "Document symbols")
					map("<leader>ws", function()
						Snacks.picker.lsp_workspace_symbols()
					end, "Workspace symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.inlayHintProvider then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle inlay hints")
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

			local servers = {
				clangd = {},
				gopls = {},
				pyright = {},
				rust_analyzer = {},
				ts_ls = {
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua", "black", "prettierd", "prettier" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- ========================================================================
	-- Completion
	-- ========================================================================
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "1.*",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "3.*",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
		},
		opts = {
			keymap = {
				preset = "enter",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				menu = {
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr ~= "" then
											icon = color_item.abbr
										end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									local highlight = "BlinkCmpKind" .. ctx.kind
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr_hl_group then
											highlight = color_item.abbr_hl_group
										end
									end
									return highlight
								end,
							},
						},
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},
			signature = { enabled = true },
		},
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = false, cpp = false }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
})
