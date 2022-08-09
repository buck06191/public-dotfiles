local util = require("lspconfig/util")

local on_attach = function(client)
	-- NOTE: You can remove this on attach function to disable format on save
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_create_autocmd("BufWritePre", {
			desc = "Auto format before save",
			pattern = "<buffer>",
			callback = vim.lsp.buf.formatting_sync,
		})
	end
end

local config = {
	-- Configure plugins
	plugins = {
		-- Add plugins, the packer syntax without the "use"
		init = {
			-- You can disable default plugins as follows:
			-- ["goolord/alpha-nvim"] = { disable = true },

			-- You can also add new plugins here as well:
			-- { "andweeb/presence.nvim" },
			{
				"s1n7ax/nvim-window-picker",
				tag = "v1.*",
				config = function()
					require("window-picker").setup()
				end,
			},
			{ "benknoble/vim-racket" },
			-- Rust support
			{
				"simrat39/rust-tools.nvim",
				after = { "nvim-lspconfig", "mason" },
				-- Is configured via the server_registration_override installed below!
				config = function()
					-- local extension_path = vim.fn.stdpath "data" .. "/dapinstall/codelldb/extension"
					-- local codelldb_path = extension_path .. "/adapter/codelldb"
					-- local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

					require("rust-tools").setup({
						server = astronvim.lsp.server_settings("rust_analyzer"),
						-- dap = {
						--   adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
						-- },
						tools = {
							inlay_hints = {
								parameter_hints_prefix = "  ",
								other_hints_prefix = "  ",
							},
						},
					})
				end,
			},
			{
				"Saecki/crates.nvim",
				after = "nvim-cmp",
				config = function()
					require("crates").setup()

					local cmp = require("cmp")
					local config = cmp.get_config()
					table.insert(config.sources, { name = "crates", priority = 1100 })
					cmp.setup(config)

					-- Crates mappings:
					local map = vim.api.nvim_set_keymap
					map(
						"n",
						"<leader>Ct",
						":lua require('crates').toggle()<cr>",
						{ desc = "Toggle extra crates.io information" }
					)
					map(
						"n",
						"<leader>Cr",
						":lua require('crates').reload()<cr>",
						{ desc = "Reload information from crates.io" }
					)
					map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a crate" })
					map(
						"v",
						"<leader>CU",
						":lua require('crates').upgrade_crates()<cr>",
						{ desc = "Upgrade selected crates" }
					)
					map(
						"n",
						"<leader>CA",
						":lua require('crates').upgrade_all_crates()<cr>",
						{ desc = "Upgrade all crates" }
					)
				end,
			},
			{
				"hrsh7th/cmp-calc",
				after = "nvim-cmp",
				config = function()
					require("crates").setup()

					local cmp = require("cmp")
					local config = cmp.get_config()
					table.insert(config.sources, { name = "calc", priority = 100 })
					cmp.setup(config)
				end,
			},
		},
		-- All other entries override the setup() call for default plugins
		["null-ls"] = function(config)
			local null_ls = require("null-ls")
			-- Check supported formatters and linters
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
			config.sources = {
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.code_actions.eslint_d,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.diagnostics.stylelint,
				null_ls.builtins.formatting.stylua,
			}
			-- set up null-ls's on_attach function
			config.on_attach = on_attach
			return config -- return final config table
		end,
		treesitter = {
			ensure_installed = {
				"lua",
				"tsx",
				"toml",
				"json",
				"yaml",
				"html",
				"scss",
				"go",
				"rust",
				"astro",
				"vue",
				"racket",
			},
		},
		["mason"] = {
			ensure_installed = { "sumneko_lua", "tsserver", "gopls", "rust-analyzer", "astro", "vue" },
		},
		packer = {
			compile_path = vim.fn.stdpath("data") .. "/packer_compiled.lua",
		},
	},

	-- LuaSnip Options
	luasnip = {
		-- Add paths for including more VS Code style snippets in luasnip
		vscode_snippet_paths = {},
		-- Extend filetypes
		filetype_extend = {
			javascript = { "javascriptreact" },
			astro = { "astro" },
		},
	},

	-- Modify which-key registration
	["which-key"] = {
		-- Add bindings
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- which-key registration table for normal mode, leader prefix
					-- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
				},
			},
		},
	},

	["neo-tree"] = {
		nesting_rules = {},
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = {
					".DS_Store",
					"thumbs.db",
					"node_modules",
					"__pycache__",
				},
			},
		},
		follow_current_file = true,
	},
	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Extend LSP configuration
	lsp = {
		--
		skip_setup = { "rust_analyzer" }, -- will be set up by rust-tools
		-- enable servers that you already have installed without lsp-installer
		servers = {},
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {
				-- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
		-- add to the server on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the lsp installer server-registration function
		-- server_registration = function(server, opts)
		--   require("lspconfig")[server].setup(opts)
		-- end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
			rust_analyzer = {
				on_attach = on_attach,
			},
			gopls = {
				on_attach = on_attach,
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						gofumpt = true,
					},
				},
			},
			yamlls = {
				settings = {
					yaml = {
						schemas = {
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
						},
					},
				},
			},
		},
	},

	-- Diagnostics configuration (for vim.diagnostics.config({}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			["<C-s>"] = { ":w!<cr>", desc = "Save File" },
			["ss"] = { ":split<Return><C-w>w", desc = "Split horizontal" },
			["sv"] = { ":vsplit<Return><C-w>w", desc = "Split vertical" },
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
	},

	-- This function is run last
	-- good place to configuring augroups/autocommands and custom filetypes
	polish = function()
		-- Set autocommands
		vim.api.nvim_create_augroup("packer_conf", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Sync packer after modifying plugins.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})

		-- Set up custom filetypes
		vim.filetype.add({
			extension = {
				astro = "astro",
			},
			-- filename = {
			--   ["Foofile"] = "fooscript",
			-- },
			-- pattern = {
			--   ["~/%.config/foo/.*"] = "fooscript",
			-- },
		})
	end,
}

return config
