-- save screen space
-- showtabline is set in lualine.nix
vim.o.showmode = false
vim.o.cmdheight = 0

-- disable mouse
vim.o.mouse = ""

-- use system clipboard (wl-copy)
vim.o.clipboard = "unnamed,unnamedplus"

-- tab settings
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.breakindent = true
vim.o.linebreak = true


-- searching settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = false

-- undo history
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

-- scrolloff
vim.o.scrolloff = 7
vim.o.sidescrolloff = 3

-- other
vim.o.laststatus = 3
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.report = 1000
vim.o.colorcolumn = "0"
vim.o.timeoutlen = 700
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
