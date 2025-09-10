return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = " AEROVIM",
						highlight = "Directory",
						separator = false, -- use a "true" to enable the default, or set your own character
					},
				},
				indicator = {
					icon = " ", -- this should be omitted if indicator style is not 'icon'
					style = "icon",
				},
				style_preset = bufferline.style_preset.no_italic,
				themable = true,
				buffer_close_icon = "󰅚 ",
				modified_icon = "󰘻 ",
				close_icon = " ",
				left_trunc_marker = " ",
				right_trunc_marker = " ",
				separator_style = "slant",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and "󱔀 " or " "
					return " " .. icon .. count
				end,
			},
		})
		vim.keymap.set("n", "<leader>bfp", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin Buffer" })
		vim.keymap.set("n", "<leader>bfr", "<cmd>BufferLineCloseRight<cr>", { desc = "Close All Buffer to Right" })
		vim.keymap.set(
			"n",
			"<leader>bfd",
			"<cmd>BufferLineGroupClose ungrouped<cr>",
			{ desc = "Close unpinned buffers" }
		)
		vim.keymap.set("n", "<leader>=", "<cmd>BufferLineCyclePrev<cr>", { desc = "Pin Buffer" })
		vim.keymap.set("n", "<leader>-", "<cmd>BufferLineCycleNext<cr>", { desc = "Pin Buffer" })
	end,
}
