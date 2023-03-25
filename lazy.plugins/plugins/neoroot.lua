return {
  'nyngwang/NeoRoot.lua',
  config = function() 
    vim.cmd'au BufEnter * NeoRoot'
    vim.keymap.set('n', '<Leader>pp', function() vim.cmd('NeoRootSwitchMode') end, NOREF_NOERR_TRUNC)
    vim.keymap.set('n', '<Leader>pn', function() vim.cmd('NeoRootChange') end, NOREF_NOERR_TRUNC)
  end
}

