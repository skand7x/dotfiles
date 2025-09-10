return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.pairs").setup()
		require("mini.move").setup()
		require("mini.cursorword").setup()
		require("mini.statusline").setup()
	end,
}
