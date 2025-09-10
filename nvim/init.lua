print("Hello skand7x")

require("config.lazy")

require("config.keymaps")

require("config.terminal")

require("config.jupyter")

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.copilot_node_command = "/home/skand7x/.nvm/versions/node/v22.16.0/bin/node"
