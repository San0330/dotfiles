local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.keymap

--Remap comma as leader key
keymap.set("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Normal --
-- Easy to work with window commands
keymap.set("n", "<leader>w", "<C-w>", opts)

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Press jj fast to exit insert mode
keymap.set("i", "jj", "<ESC>", opts)

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
keymap.set("v", "p", '"_dP', opts)

-- Move text up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Better terminal navigation
keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Traverse buffer
keymap.set("n", "<Tab>", ":bn<CR>", opts)
keymap.set("n", "<S-Tab>", ":bp<CR>", opts)

-- save file
keymap.set("n", "<leader>s", ":w<CR>", opts)
keymap.set("n", "<leader>S", ":w!<CR>", opts)

-- open root directory in vs code
keymap.set("n", "<leader>vs", "<cmd>!code .<CR>", opts)

-- clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohls<CR>", opts)

-- Format code
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true,timeout_ms=5000}' ]])
keymap.set("n", "<leader>f", "<cmd>Format<CR>", opts)

-- page down with space key
keymap.set('n', '<SPACE>', "<c-d>", opts)

vim.api.nvim_set_hl(
    0,
    'TrailingSpacesHL',
    { link = 'DraculaSelection' }
)

vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('autoFormatOnSave', { clear = true }),
    pattern = '*',
    callback = function()
        vim.lsp.buf.format { async = false }
    end
})

vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('removeTrailingSpaceOnSave', { clear = true }),
    pattern = '*',
    callback = function()
        vim.cmd ":%s/\\s\\+$//e"
    end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
    group = vim.api.nvim_create_augroup('highlightTrailingSpace', { clear = true }),
    pattern = '*',
    callback = function()
        vim.cmd "match TrailingSpacesHL /\\s\\+$/"
    end
})

-- for performance improvement remove highlights
vim.api.nvim_create_autocmd('BufWinLeave', {
    group = vim.api.nvim_create_augroup('removeHighlightTrailingSpace', { clear = true }),
    pattern = '*',
    callback = function()
        vim.cmd ":call clearmatches()"
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('js/ts abbreviations', { clear = true }),
    pattern = { 'javascriptreact', 'typescriptreact' },
    callback = function()
        vim.cmd "iabbrev <buffer> form from"
    end
})

-- black hole variant of delete operator
keymap.set('n', '-', "\"_d", opts)
keymap.set('v', '-', "\"_d", opts)

-- surrond with double quotes in normal & visual mode (for learning purpose of visual mode maps)
keymap.set('n', '<leader>"', 'viw<esc>a"<esc>bi"<esc>lel', opts)
keymap.set('v', '<leader>"', '<esc>`>a"<esc>`<i"<esc>`>l', opts)


vim.cmd [[
augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
]]
