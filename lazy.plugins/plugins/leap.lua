return {
  'ggandor/leap.nvim', -- repeat.vim is in .vimrc.plug
  config = function()
    require('leap').set_default_keymaps()
  end
}
