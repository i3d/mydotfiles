return {
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local actions = require('telescope.actions')
    require("telescope").setup{
      defaults = {
        layout_config = {
          vertical = { width = 0.6 }
        },
        set_env = { ['COLORTERM'] = 'truecolor' },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",
        },
        file_browser = {
          theme = "ivy",
          path = "%:p:h",        
          hidden = true,         
          grouped = true,        
          files = true,          
          depth = 5,             
          collapse_dirs = true,  
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,   
          mappings = {           
            ["i"] = {            
              -- your custom insert mode mappings
            },                   
            ["n"] = {            
              -- your custom normal mode mappings
            },                   
          },                     
        },
      },
    }
    --require('telescope').load_extension('fzf')
    require('telescope').load_extension('file_browser')
  end
}
