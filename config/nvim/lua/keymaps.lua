local g = vim.g
local k = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

k("", "<Space>", "<Nop>", o)
g.mapleader = " "
g.maplocalleader = " "

function n(from,to)
    k("n",from,to,opts)
end

n('<leader>ff', ':Telescope fd<CR>')
n('<leader>fG', ':Telescope live_grep<CR>')
n('<leader>fg', ':Telescope grep_string<CR>')

n('<leader>gd', function() lsp.definition() end)
n('<leader>gh', function() lsp.hover() end)
n('<leader>gD', function() lsp.implementation() end)
n('<leader>gs', function() lsp.signature_help() end)
n('<leader>gr', function() lsp.references() end)
n('<leader>gR', function() lsp.rename() end)
n('<leader>ga', function() lsp.code_action() end)