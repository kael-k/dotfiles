vim.cmd([[
	syntax on                       "syntax highlighting, see :help syntax

	set termguicolors               "Enable 24-bit color

	set noexpandtab                 "do not expanding tab to spaces
	set tabstop=4                   "setting tab to 4 columns
	set shiftwidth=4
	set softtabstop=0
	set smarttab


	" ===== Show invisibles (tabs vs spaces) =====
	set list
	set listchars=tab:→→,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:·

	set number                      "display line number
	set relativenumber              "display relative line numbers
	set path+=**                    "improves searching, see :help path
	set noswapfile                  "disable use of swap files
	set wildmenu                    "completion menu
	set backspace=indent,eol,start  "ensure proper backspace functionality
	set undodir=~/.cache/nvim/undo  "undo ability will persist after exiting file
	set undofile                    "see :help undodir and :help undofile
	set incsearch                   "see results while search is being typed, see :help incsearch
	set smartindent                 "auto indent on new lines, see :help smartindent
	set ic                          "ignore case when searching
	set colorcolumn=80,120          "display color when line reaches pep8 standards
	set showmatch                   "display matching bracket or parenthesis
	set hlsearch incsearch          "highlight all pervious search pattern with incsearch
	set nowrap                      "disable text wrapping
]])

vim.g.mapleader = " "

vim.api.nvim_set_keymap("i", "<C-e>", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-e>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all without saving" })
vim.keymap.set("n", "<leader>W", ":wa<CR>", { desc = "Write all buffers" })
vim.keymap.set("n", "<leader>sdo", ":diffthis<CR>", { desc = "Diff this panel" })
vim.keymap.set("n", "<leader>sdq", ":diffoff<CR>", { desc = "Quit diff this panel" })
vim.keymap.set("n", "<leader>wto", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>wtq", ":tabclose<CR>", { desc = "Quit/Close new tab" })
vim.keymap.set("n", "<leader>wth", ":-tabmove<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<leader>wtl", ":+tabmove<CR>", { desc = "Move tab right" })
vim.keymap.set("n", "<leader>wtg", ":0tabmove<CR>", { desc = "Move tab first" })
vim.keymap.set("n", "<leader>wtG", ":tabmove<CR>", { desc = "Move tab last" })
