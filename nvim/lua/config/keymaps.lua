vim.keymap.set("n", "<C-n>", ":Neotree toggle left<CR>", {})

local builtin = require("telescope.builtin")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
map("n", "<leader>w", ":w<CR>", opts) -- Save
map("n", "<leader>q", ":q<CR>", opts) -- Quit
map("n", "<leader>h", ":nohlsearch<CR>", opts) -- Clear search
map("n", "<leader>c", ":bd<CR>", opts) -- Close buffer

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<leader>bn", ":bnext<CR>", opts)
map("n", "<leader>bp", ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
map("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", opts)

map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", opts)

-- Requires: nvim-treesitter-textobjects
-- Enable enhanced motions like:
-- - `af` = around function
-- - `if` = inner function
-- - `ac` = around class
-- - `ic` = inner class
-- Already provided by treesitter when configured correctly, just use motions like:
-- Example usage:
-- - `vaf` to visually select a function
-- - `dac` to delete a class
-- - `yif` to yank inside a function
-- If you want, you can manually define:
-- (but usually Treesitter handles this via queries)

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "p", '"_dP', opts) -- paste without yanking

map("i", "jk", "<Esc>", opts) -- quick escape

map("n", "<leader>tt", "<cmd>vsplit | terminal<CR>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts) -- escape terminal mode

vim.keymap.set("n", "<leader>th", ":Themery<CR>")

-- Suggest installing plugins like:
-- - leap.nvim / flash.nvim / hop.nvim for fast navigation
-- - mini.move or vim-sneak for smarter motions

-- Example with mini.move (if installed):
-- map("n", "<A-j>", ":MoveLine(1)<CR>", opts)
-- map("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
