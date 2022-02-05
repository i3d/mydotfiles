-- vim.cmd("colorscheme darkmatrix")
-- vim.cmd("colorscheme carbondark")
-- vim.cmd("colorscheme everforest")
vim.cmd("colorscheme breakingbad")

if string.match(vim.g.colors_name, "matrix") then require('plugins.matrix') end
if string.match(vim.g.colors_name, "carbondark") then require('plugins.carbondark') end
if string.match(vim.g.colors_name, "breakingbad") then require('plugins.breakingbad') end
-- require('plugins.onedark')
-- require('plugins.nerd')
-- require('plugins.light')
