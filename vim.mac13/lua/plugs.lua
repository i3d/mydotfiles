-- vim.cmd("colorscheme darkmatrix")
vim.cmd("colorscheme carbondark")

if string.match(vim.g.colors_name, "matrix") then require('plugins.matrix') end
if string.match(vim.g.colors_name, "carbondark") then require('plugins.carbondark') end
-- require('plugins.onedark')
-- require('plugins.nerd')
-- require('plugins.light')
