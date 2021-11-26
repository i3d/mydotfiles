-- vim.cmd("colorscheme darkmatrix")
vim.cmd("colorscheme quitedark")

if string.match(vim.g.colors_name, "matrix") then require('plugins.matrix') end
if string.match(vim.g.colors_name, "quitedark") then require('plugins.quitedark') end
-- require('plugins.onedark')
-- require('plugins.nerd')
-- require('plugins.light')
