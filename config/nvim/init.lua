local c = vim.cmd
local g = vim.g
local o = vim.opt
local k = vim.keymap
local lsp = vim.lsp.buffer

g.mapleader = " "

o.guicursor = ""
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.termguicolors = true
o.number = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.smartindent = true
o.relativenumber = true
o.cmdheight = 1

k.set('n', '<leader>ff', ':Telescope fd<CR>')
k.set('n', '<leader>fg', ':Telescope grep_string<CR>')

k.set('n', '<leader>gd', function() lsp.definition() end)
k.set('n', '<leader>gh', function() lsp.hover() end)
k.set('n', '<leader>gD', function() lsp.implementation() end)
k.set('n', '<leader>gs', function() lsp.signature_help() end)
k.set('n', '<leader>gr', function() lsp.references() end)
k.set('n', '<leader>gR', function() lsp.rename() end)
k.set('n', '<leader>ga', function() lsp.code_action() end)

-- require('onedark').load()