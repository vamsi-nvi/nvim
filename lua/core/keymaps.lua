vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { silent = true }

local function desc(description)
	return vim.tbl_extend("force", opts, { desc = description })
end

map("n", "<A-z>", ":set wrap!<CR>", desc("Toggle Line Wrap"))

-- Window Resizing
map("n", "<C-Up>", ":resize +2<CR>", desc("Increase Window Height"))
map("n", "<C-Down>", ":resize -2<CR>", desc("Decrease Window Height"))
map("n", "<C-Left>", ":vertical resize -2<CR>", desc("Decrease Window Width"))
map("n", "<C-Right>", ":vertical resize +2<CR>", desc("Increase Window Width"))

-- Window Navigation
map("n", "<C-h>", "<C-w>h", desc("Go to Left Window"))
map("n", "<C-j>", "<C-w>j", desc("Go to Lower Window"))
map("n", "<C-k>", "<C-w>k", desc("Go to Upper Window"))
map("n", "<C-l>", "<C-w>l", desc("Go to Right Window"))

-- Terminal Navigation
map("t", "<C-h>", "<C-\\><C-n> <C-w>h", desc("Go to Left Window"))
map("t", "<C-j>", "<C-\\><C-n> <C-w>j", desc("Go to Lower Window"))
map("t", "<C-k>", "<C-\\><C-n> <C-w>k", desc("Go to Upper Window"))
map("t", "<C-l>", "<C-\\><C-n> <C-w>l", desc("Go to Right Window"))

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==", desc("Move Line Down"))
map("n", "<A-k>", ":m .-2<CR>==", desc("Move Line Up"))
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", desc("Move Line Down"))
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", desc("Move Line Up"))
map("v", "<A-j>", ":m '>+1<CR>gv=gv", desc("Move Selection Down"))
map("v", "<A-k>", ":m '<-2<CR>gv=gv", desc("Move Selection Up"))

-- Buffers
map("n", "<TAB>", ":bnext<CR>", desc("Next Buffer"))
map("n", "<S-TAB>", ":bprev<CR>", desc("Previous Buffer"))
map("n", "<leader>bn", ":bnext<CR>", desc("Next Buffer"))
map("n", "<leader>bp", ":bprev<CR>", desc("Previous Buffer"))
map("n", "<leader>bd", ":bdelete<CR>", desc("Delete Buffer"))

-- Splits & UI
map("n", "<leader>sh", ":split<CR>", desc("Split Horizontal"))
map("n", "<leader>sv", ":vsplit<CR>", desc("Split Vertical"))
map("n", "<leader>q", ":quit<CR>", desc("Quit"))
map("n", "<Esc>", ":nohlsearch<CR>", desc("Clear Search Highlights"))

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, desc("Previous Diagnostic"))
map("n", "]d", vim.diagnostic.goto_next, desc("Next Diagnostic"))
map("n", "<leader>ld", vim.diagnostic.open_float, desc("Line Diagnostics"))

-- Terminal Specific
map("t", "<Esc>", "<C-\\><C-n>", desc("Exit Terminal Mode"))
map("t", "<C-n>", "<C-\\><C-n> :bnext<CR>", desc("Next Buffer (Terminal)"))

-- Snacks Explorer & Picker
map("n", "<leader>e", function()
	Snacks.explorer()
end, desc("File Explorer"))
map("n", "<leader>ff", function()
	Snacks.picker.files()
end, desc("Find Files"))
map("n", "<leader><leader>", function()
	Snacks.picker.buffers()
end, desc("Switch Buffers"))
map("n", "<leader>fg", function()
	Snacks.picker.grep()
end, desc("Grep Text"))
map("n", "<leader>fd", function()
	Snacks.picker.diagnostics()
end, desc("Search Diagnostics"))
map("n", "<leader>ut", function()
	Snacks.picker.colorschemes()
end, desc("Change Colorscheme"))

-- Snacks Git
map("n", "<leader>gb", function()
	Snacks.picker.git_branches()
end, desc("Git Branches"))
map("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, desc("Git Log"))
map("n", "<leader>gL", function()
	Snacks.picker.git_log_line()
end, desc("Git Log (Line)"))
map("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, desc("Git Status"))
map("n", "<leader>gS", function()
	Snacks.picker.git_stash()
end, desc("Git Stash"))
map("n", "<leader>gd", function()
	Snacks.picker.git_diff()
end, desc("Git Diff"))
map("n", "<leader>gf", function()
	Snacks.picker.git_log_file()
end, desc("Git File History"))
map({ "n", "v" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, desc("Git Browse (Web)"))

map("n", "<C-`>", function()
	require("nvterm.terminal").toggle("horizontal")
end)
map("n", "<leader>t", function()
	require("nvterm.terminal").toggle("vertical")
end)
