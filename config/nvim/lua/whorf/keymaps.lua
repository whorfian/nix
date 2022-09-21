function k(m, f, t)
	vim.api.nvim_set_keymap(m, f, t, { noremap = true, silent = true })
end
function n(f, t)
	k("n", f, t)
end
function i(f, t)
	k("i", f, t)
end
function v(f, t)
	k("v", f, t)
end
function x(f, t)
	k("x", f, t)
end

--- Any Mode?
k("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- Normal Mode
n("<leader>ff", ":Telescope fd<CR>")
n("<leader>fG", ":Telescope live_grep<CR>")
n("<leader>fg", ":Telescope grep_string<CR>")
-- Navigate buffers
n("L", ":bnext<CR>")
n("H", ":bprevious<CR>")
-- Move text up and down
n("<A-j>", "<Esc>:m .+1<CR>==gi")
n("<A-k>", "<Esc>:m .-2<CR>==gi")

--- Insert Mode
-- Press jk fast to exit insert mode
i("jk", "<ESC>")

--- Visual Mode
-- Fix weird yank buffer stuff
v("p", '"_dP')
-- Stay in indent mode
v("<", "<gv")
v(">", ">gv")
-- Move text up and down
v("<A-j>", ":m .+1<CR>==")
v("<A-k>", ":m .-2<CR>==")

--- Visual Block Mode
-- Move text up and down
x("<A-j>", ":m '>+1<CR>gv-gv")
x("<A-k>", ":m '<-2<CR>gv-gv")

-- nf('<leader>gd', function() lsp.definition() end)
-- nf('<leader>gh', function() lsp.hover() end)
-- nf('<leader>gD', function() lsp.implementation() end)
-- nf('<leader>gs', function() lsp.signature_help() end)
-- nf('<leader>gr', function() lsp.references() end)
-- nf('<leader>gR', function() lsp.rename() end)
-- nf('<leader>ga', function() lsp.code_action() end)
