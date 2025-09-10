return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		views = {
			cmdline_popup = {
				position = {
					row = vim.o.lines + 16, -- 4 lines from the bottom
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
				border = {
					style = "rounded",
				},
			},
		},
	},
}
