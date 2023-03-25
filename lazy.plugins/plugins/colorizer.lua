return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    if not os.getenv('NOTRUECOLOR') then
      require'colorizer'.setup()
    end
  end
}
