vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.updatetime = 300
vim.opt.timeoutlen = 400
vim.opt.confirm = true
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.winborder = "single"
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.background = "dark"

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.lsp.set_log_level("OFF")
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.g.last_colorscheme = vim.g.colors_name
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.g.last_colorscheme then
			vim.cmd.colorscheme(vim.g.last_colorscheme)
		end
	end,
})
