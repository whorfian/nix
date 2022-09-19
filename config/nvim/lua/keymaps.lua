local g = vim.g
local k = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

k("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

function ns(from,to)
    k("n",from,to,opts)
end
function nf(from,to)
    k("n",from,to,"<cmd>lua "..tostring(opts).."()<CR>")
end

ns('<leader>ff', ':Telescope fd<CR>')
ns('<leader>fG', ':Telescope live_grep<CR>')
ns('<leader>fg', ':Telescope grep_string<CR>')

nf('<leader>gd', lsp.definition)
nf('<leader>gh', lsp.hover)
nf('<leader>gD', lsp.implementation)
nf('<leader>gs', lsp.signature_help)
nf('<leader>gr', lsp.references)
nf('<leader>gR', lsp.rename)
nf('<leader>ga', lsp.code_action)