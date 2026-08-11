vim.cmd([[
	set termguicolors               "Enable 24-bit color

	set noexpandtab                 "do not expanding tab to spaces
	set tabstop=4                   "setting tab to 4 columns
	set shiftwidth=4

	" ===== Show invisibles (tabs vs spaces) =====
	set list
	set listchars=tab:→→,nbsp:␣,trail:•,extends:⟩,precedes:⟨

	set number                      "display line number
	set relativenumber              "display relative line numbers
	set path+=**                    "improves searching, see :help path
	set noswapfile                  "disable use of swap files
	set wildoptions+=fuzzy          "fuzzy matching in the native cmdline completion menu
	set undofile                    "persist undo; default undodir is auto-created, see :help undodir
	set smartindent                 "auto indent on new lines, see :help smartindent
	set ic                          "ignore case when searching
	set colorcolumn=80,120          "display color when line reaches pep8 standards
	set showmatch                   "display matching bracket or parenthesis
	set nowrap                      "disable text wrapping
]])

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.diagnostic.config({
	severity_sort = true,
	virtual_lines = { current_line = true },
})

-- Enable title
vim.opt.title = true
if #vim.fn.argv() > 0 then
  -- Use the filename of the first argument
  vim.opt.titlestring = "nvim - " .. vim.fn.fnamemodify(vim.fn.argv(0), ':t')
else
  -- Use the basename of the current working directory
  vim.opt.titlestring = "nvim - " .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

-- esc with <C-e> in insert, view and terminal mode
vim.keymap.set("i", "<C-e>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-e>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-e>", "<C-\\><C-n>", { noremap = true, silent = true })

-- <C-w> in view and terminal mode
vim.keymap.set("v", "<C-w>", "<Esc><C-w>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { noremap = true, silent = true })

-- quit shortcuts
vim.keymap.set("n", "<leader>qq", ":q!<CR>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>qw", ":wq<CR>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>qQ", ":qa!<CR>", { desc = "Quit all without saving" })
vim.keymap.set("n", "<leader>qW", ":wa<CR>", { desc = "Save all and quit" })

-- editor options
vim.keymap.set("n", "<leader>ed", function()
	vim.cmd(vim.wo.diff and "diffoff" or "diffthis")
end, { desc = "Toggle diff on this window" })
vim.keymap.set("n", "<leader>ew", ":set wrap!<CR>", { desc = "Toggle line wrap" })
vim.keymap.set("n", "<leader>el", ":set list!<CR>", { desc = "Toggle invisibles (listchars)" })
vim.keymap.set("n", "<leader>es", ":set spell!<CR>", { desc = "Toggle spell check" })
vim.keymap.set("n", "<leader>en", function()
	if vim.wo.relativenumber then
		vim.wo.number, vim.wo.relativenumber = false, false
	elseif vim.wo.number then
		vim.wo.number, vim.wo.relativenumber = true, true
	else
		vim.wo.number, vim.wo.relativenumber = true, false
	end
end, { desc = "Cycle line numbers: none > absolute > relative" })

-- tabs (<A-…> prefix and modes matching the smart-splits window family)
for key, tab in pairs({
	o = { "tabnew", "Open new tab" },
	q = { "tabclose", "Quit/Close tab" },
	h = { "-tabmove", "Move tab left" },
	l = { "+tabmove", "Move tab right" },
	g = { "0tabmove", "Move tab first" },
	G = { "tabmove", "Move tab last" },
}) do
	vim.keymap.set({ "n", "v", "i", "t" }, "<A-t>" .. key, "<cmd>" .. tab[1] .. "<CR>", { desc = tab[2] })
end

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy selection to system clipboard' })
vim.keymap.set('v', '<leader>d', '"+d', { desc = 'Cut selection to system clipboard' })
vim.keymap.set("n", "<leader>r", ":& | normal! n<CR>", { desc = "Apply last substitution, move to next match" })

-- Vim related
vim.keymap.set('n', '<leader>vl', ':Lazy<CR>', { desc = 'Open Lazy' })

-- Help / docs
vim.keymap.set("n", "<leader>hd", vim.lsp.buf.hover, { desc = "Show symbol documentation (native: K)" })
vim.keymap.set("n", "<leader>hs", vim.lsp.buf.signature_help, { desc = "Show signature help (native: <C-s> in insert)" })
