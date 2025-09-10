return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
		"jay-babu/mason-nvim-dap.nvim",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dapui").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "python" },
			automatic_installation = true,
		})
		require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

		-- Optional: auto open/close dapui
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Keybindings
		vim.keymap.set("n", "<leader>dbp", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
		vim.keymap.set("n", "<leader>dbs", dap.step_into, { desc = "Start/Continue Debugging" })
	end,
}
