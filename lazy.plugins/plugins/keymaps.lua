return {
  "folke/which-key.nvim",

  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 100
    --     require("which-key").setup({
    --       -- your configuration comes here
    --       -- or leave it empty to use the default settings
    --       -- refer to the configuration section below
    --     })
    local wk = require("which-key")
    wk.register({
      ['<leader>0'] = { ':Restart<cr>', 'Restart Nvim'},
      ['<leader>1'] = { '<C-W>s', '2 stacks'},
      ['<leader>2'] = { '<C-W>v', '2 columns'},
      ['<leader>/'] = { ':CocList grep<cr>', 'grep'},
      --['<leader>C'] = { ':CocList colors', 'colors'},
      ['<leader>C'] = { ':Telescope colorscheme<cr>', 'colors'},
      ['<leader>.'] = { ':CocList files<cr>', 'open files here'},
      ['<leader>,'] = { ':CocList words<cr>', 'searchwords'},
      ['<leader>q'] = { ':q!<cr>', 'quit'},
      ['<leader>;'] = { ':CocList outline<cr>', 'outline'},
      ['<leader>V'] = { ':Commands<cr>', 'cmds'},
      ['<leader>='] = { '<C-W>=', 'balance window'},
      ['<leader>d'] = { ':bd<cr>', 'kill buffer'},
      ['<leader>e'] = { ':CocCommand explorer<cr>', 'coc explorer'},
      ['<leader>F'] = { ':Files<cr>', 'files'},
      ['<leader>v'] = { ':Telescope file_browser<cr>', 'file browser'},
      ['<leader>f'] = { ':VsplitVifm<cr>', 'vifm'},
      ['<leader>z'] = { ':Twilight<cr>', 'zen'},
      ['<leader>?'] = { ':CocList maps<cr>', 'keymaps'},
      ["<leader>'"] = { ':FloatermNew --width=150 --height=50<cr>', 'shell'},
      ['<leader>h'] = { ':FloatermKill', 'kill shell'},
      ['<leader>n'] = { ':bnext', 'next buffer'},
      ['<leader>u'] = { ':vsp #', 'reopen'},

      ['<leader>a'] = { name = '+actions' },

      ['<leader>b'] = { name = '+buffer' },
      ['<leader>b1'] = { ':b1<cr>', "buffer 1"},
      ['<leader>b2'] = { ':b2<cr>', "buffer 2"},
      ['<leader>bd'] = { ':bd<cr>', "delete buffer"},
      ['<leader>bf'] = { ':bfirst<cr>', "first"},
      ['<leader>bh'] = { ':Startify<cr>', "home"},
      ['<leader>bl'] = { ':blast<cr>', "last"},
      ['<leader>bn'] = { ':bnext<cr>', "next"},
      ['<leader>bp'] = { ':bprevious<cr>', "prev"},
      ['<leader>b?'] = { ':Buffers<cr>', "fzf buffers"},
      -- ['<leader>bb'] = { ':CocList buffers<cr>', "coc buffers"},
      ['<leader>bb'] = { ':Telescope buffers<cr>', "buffers"},
      ['<leader>bm'] = { ':CocList marks<cr>', "coc marks"},

      ['<leader>c'] = { name = '+code' },
      
      ['<leader>g'] = { name = '+git' },

      ['<leader>G'] = { name = '+Google' },

      ['<leader>R'] = { name = '+Rust/Go' },

      ['<leader>l'] = { name = '+lsp' },

      ['<leader>o'] = { name = '+open' },
      ['<leader>o0'] = { ':vsp ~/.config/nvim/lua/plugins/keymaps.lua<cr>', 'keymap'},
      ['<leader>o1'] = { ':vsp ~/.vimrc<cr>', 'vimrc'},
      ['<leader>o2'] = { ':vsp ~/.vimrc.plug<cr>', 'vimrcplug'},
      ['<leader>o3'] = { ':vsp ~/.vim/init.lua<cr>', 'init.lua'},
      ['<leader>o4'] = { ':vsp ~/.zshrc<cr>', 'zshrc'},
      ['<leader>o5'] = { ':vsp ~/.zshrc.pre-oh-my-zsh<cr>', 'zshrc.pre'},
      ['<leader>o6'] = { ':vsp ~/.zshenv<cr>', 'zshenv'},
      ['<leader>o7'] = { ':vsp ~/bin/cheat<cr>', 'cheatsheet'},
      ['<leader>o9'] = { ':vsp ~/.config/nvim/lua/plugins/init.lua<cr>', 'plugins'},
      ['<leader>ow'] = { ':!vieb "<cWORD>"<cr>', 'open link'},
      ['<leader>os'] = { ':!vieb "google.com/search?q=<cword>"<cr>', 'open link'},
      ['<leader>ov'] = { ':vsp /tmp/foo<cr>', 'open tmp'},

      ['<leader>P'] = { name = '+Piper' },

      ['<leader>p'] = { name = '+projects' },

      ['<leader>s'] = { name = '+search' },

      ['<leader>t'] = { name = '+terminal' },

      ['<leader>x'] = { name = '+xDebug' },

      ['<leader>T'] = { name = '+Telescope' },

      ['<leader>w'] = { name = '+windows' },
    })
  end,
}
