return {
	"zaldih/themery.nvim",
	priority = 1000,
	config = function()
		require("themery").setup({
			themes = { "tokyonight-night", "cyberdream", "gruvbox", "tokyodark" }, -- Your list of installed colorschemes.
			livePreview = true,
		})
	end,
}
