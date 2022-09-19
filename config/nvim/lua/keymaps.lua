local g = vim.g
local k = vim.api.nvim_set_keymap
local lsp = vim.lsp.buffer
local opts = { noremap = true, silent = true }

k("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

function ns(from,to)
    k("n",from,to,opts)
end
function nf(from,to)
    k("n",from,to,opts)
end

ns('<leader>ff', ':Telescope fd<CR>')
ns('<leader>fG', ':Telescope live_grep<CR>')
ns('<leader>fg', ':Telescope grep_string<CR>')

nf('<leader>gd', function() lsp.definition() end)
nf('<leader>gh', function() lsp.hover() end)
nf('<leader>gD', function() lsp.implementation() end)
nf('<leader>gs', function() lsp.signature_help() end)
nf('<leader>gr', function() lsp.references() end)
nf('<leader>gR', function() lsp.rename() end)
nf('<leader>ga', function() lsp.code_action() end)