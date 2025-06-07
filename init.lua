vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.opt.signcolumn = "auto:2"
-- Ensure the directory of this config is on the runtimepath when using `-u init.lua`
local source = debug.getinfo(1, "S").source:sub(2)
local config_dir = vim.fn.fnamemodify(source, ":p:h")
vim.opt.rtp:prepend(config_dir)
require("config.lazy")
-- lazy.nvim may reset the runtimepath, so ensure our config dir is still first
vim.opt.rtp:prepend(config_dir)
require("config.keymap").setup()
require("config.notification").setup()
require("config.save").setup()
