return {
	{
		"folke/tokyonight.nvim",
		opts = {},
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.o.background = "dark" -- or "light" for light mode
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		config = function()
			vim.cmd("colorscheme cyberdream")
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
		config = function(_, opts)
			require("tokyodark").setup(opts)
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
}
