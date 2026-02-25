vim.loader.enable()

local utils = require("utils")

local expected_version = "0.11.6"
utils.is_compatible_version(expected_version)

vim.cmd("runtime options.vim")
vim.cmd("runtime plugins.vim")
vim.cmd("runtime bindings.vim")
vim.cmd("runtime commands.vim")
vim.cmd("runtime color.vim")
vim.cmd("runtime statusline.vim")
