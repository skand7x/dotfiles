return {
	{
		"3rd/image.nvim",
		build = false,
		opts = {
			backend = "kitty",
			processor = "magick_cli",
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
		},
	},
	{
		"benlubas/molten-nvim",
		lazy = false,
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		config = function()
			vim.g.molten_auto_open_output = false
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true

			vim.keymap.set(
				"n",
				"<leader>e",
				":MoltenEvaluateOperator<CR>",
				{ desc = "evaluate operator", silent = true }
			)

			vim.keymap.set(
				"n",
				"<leader>os",
				":noautocmd MoltenEnterOutput<CR>",
				{ desc = "open output window", silent = true }
			)

			vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })

			vim.keymap.set(
				"v",
				"<leader>r",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				{ desc = "execute visual selection", silent = true }
			)

			vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })

			vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

			vim.keymap.set(
				"n",
				"<leader>mx",
				":MoltenOpenInBrowser<CR>",
				{ desc = "open output in browser", silent = true }
			)
		end,
	},
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("quarto").setup({
				debug = false,
				closePreviewOnExit = true,
				lspFeatures = {
					enabled = true,
					chunks = "curly",
					languages = { "r", "python", "julia", "bash", "html" },
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				codeRunner = {
					enabled = true,
					default_method = "molten",
					ft_runners = {},
					never_run = { "yaml" },
				},
			})
		end,
		vim.keymap.set("n", "<leader>jqc", "<cmd>QuartoSend<cr>", { desc = "Quarto Run Cell" }),
	},
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false,
		config = function()
			require("jupytext").setup({
				style = "markdown",
				output_extension = "md",
				force_ft = "markdown",
			})
		end,
	},
}
