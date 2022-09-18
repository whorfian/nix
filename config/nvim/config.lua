--[[
Credits/Resources:
- LunarVim/Neovim-from-scratch
- david-kunz/vim
- sherubthakur/dotfiles/tree/master/modules/nvim
- tjdevries/config_manager/blob/master/xdg_config/nvim
- ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim
]]

local c = vim.cmd
local g = vim.g
local o = vim.opt
local k = vim.keymap
local lsp = vim.lsp.buffer

require('onedark').load()

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

-- This uses the current word? Want a general version too
k.set('n', '<leader>fG', ':Telescope live_grep<CR>')
k.set('n', '<leader>fg', ':Telescope grep_string<CR>')

-- These aren't working
k.set('n', '<leader>gd', function() lsp.definition() end)
k.set('n', '<leader>gh', function() lsp.hover() end)
k.set('n', '<leader>gD', function() lsp.implementation() end)
k.set('n', '<leader>gs', function() lsp.signature_help() end)
k.set('n', '<leader>gr', function() lsp.references() end)
k.set('n', '<leader>gR', function() lsp.rename() end)
k.set('n', '<leader>ga', function() lsp.code_action() end)


-- let g:which_key_map.s = {
--     \ 'name' : '+Search' ,
--     \ 'f' : [':Telescope find_files',            'Files'],
--     \ 't' : [':Telescope live_grep',             'Text (live grep)'],
--     \ 'b' : [':Telescope buffers',               'Open Buffers'],
--     \ 'h' : [':Telescope help_tags',             'Help tags'],
--     \ 's' : [':Telescope lsp_workspace_symbols', 'Workspace symbols'],
--     \ 'm' : [':Telescope marks',                 'Marks'],
--     \ }

-- file nav
-- completion
-- formatting
-- folds
-- snippets


-- require "plugins"
-- require "options"
-- require "lsp"
-- require "ts"
-- require "cmp"
-- require "snip"
-- require "telescope"
-- require "whichkey"
-- require "autocommands"
-- require "autopairs"
-- require "comment"
-- require "gitsigns"
-- require "keymaps"
-- require "colorscheme"

-- require "bufferline"
-- require "lualine"
-- require "project"
-- require "impatient"
-- require "indentline"
-- require "alpha"
