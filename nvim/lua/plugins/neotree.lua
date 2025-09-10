return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	-- -@module "neo-tree"
	-- -@type neotree.Config?
	opts = {
		filesystem = {
			follow_current_file = {
				enabled = true,
			},
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
		},
	},
}
