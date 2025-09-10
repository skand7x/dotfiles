return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		dashboard = {
			preset = {
				header = [[


 █████╗ ███████╗██████╗  ██████╗ ██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔════╝██╔══██╗██╔═══██╗██║   ██║██║████╗ ████║
███████║█████╗  ██████╔╝██║   ██║██║   ██║██║██╔████╔██║
██╔══██║██╔══╝  ██╔══██╗██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║███████╗██║  ██║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                           ]],
			},
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
	},
	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>ut",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Toggle Terminal",
		},
	},
}
