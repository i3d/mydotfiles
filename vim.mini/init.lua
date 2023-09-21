local execute = vim.api.nvim_command
local fn = vim.fn
local api = vim.api
local gl = vim.g
-- !!!!!!!!!!!!!! LOCAL PLUGINS !!!!!!!!!!!!!!! --

-- global inspect
function _G.p(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end
  print(table.concat(objects, '\n'))
  return ...
end
local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }


---
--
--    START LAZY Plugin Manager
--
---

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    -- "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.statuscolumn = '%l|%r'

-- 'junegunn/fzf', { 'do',: { -> fzf#install() } }
-- 'junegunn/fzf.vim',
-- plugins dir: ~/.config/nvim/lua/plugins
require("lazy").setup('plugins')
require("mason").setup{}
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "rust_analyzer", "gopls", }, 
  automatic_installation = true,
}
