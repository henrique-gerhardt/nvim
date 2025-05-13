vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.opt.signcolumn = "auto:2"
require("config.lazy")
require("config.keymap").setup()
require("config.notification").setup()
require("config.save").setup()
