return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.animate').setup()
    --require('mini.base16').setup()
    require('mini.basics').setup()
    require('mini.comment').setup()
    require('mini.completion').setup()
    require('mini.cursorword').setup()
    require('mini.doc').setup()
    require('mini.fuzzy').setup()
    require('mini.indentscope').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.map').setup()
    require('mini.misc').setup()
    require('mini.pairs').setup()
    require('mini.sessions').setup()
    require('mini.starter').setup()
    require('mini.surround').setup()
    --    require('mini.statusline').setup()
  end
}
