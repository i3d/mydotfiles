
local execute = vim.api.nvim_command
local fn = vim.fn
local api = vim.api
local gl = vim.g
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
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end
---- packer packages.
require("packer").startup(function(use)
  -- Packer can manage itself as an optional plugin
  use "wbthomason/packer.nvim"
  -- other packages.
  -- other packages.
  use {"terrortylor/nvim-comment", opt = true}
  use {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter"
  }
  -- speed up startup time.
  use 'lewis6991/impatient.nvim'
end)
require('nvim_comment').setup()
---- packer packages.
--
--
--
require('symbols-outline').setup()
if not os.getenv('NOTRUECOLOR') then
  require'colorizer'.setup()
end
require("lsp-rooter").setup()
require('hop').setup()
require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,
    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',
    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})
--
require('numb').setup{
   show_numbers = true, -- Enable 'number' for the window while peeking
   show_cursorline = true -- Enable 'cursorline' for the window while peeking
}
local actions = require('telescope.actions')
require("telescope").setup{
  defaults = {
	set_env = { ['COLORTERM'] = 'truecolor' },
  },
  pickers = {
    buffers = {
      theme = "dropdown",
    },
    find_files = {
      theme = "dropdown",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",
    },
  },
}
require('telescope').load_extension('fzf')
-- ----------------------------------------------
--
require('FTerm').setup({
    dimensions = {
        height = 0.8,
        width = 0.45,
        x = 0.95,
        y = 0.8
    },
    border = 'single' -- or 'double'
})
-- trouble
require('trouble').setup( {
    height = 10,
} )
local trouble = require("trouble.providers.telescope")
local telescope_t = require("telescope")
telescope_t.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}
-- function to attach completion when setting up lsp
local on_attach = function(client)
  require'completion'.on_attach(client)
  require'lsp_signature'.on_attach({
      bind = true,
      doc_lines = 3,  -- insert mode doc.
      fix_pos = true, -- not autoclose the window.
      handler_opts = {
        border = "shadow"
      },
  })
end
-- lspinstall
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{ on_attach=on_attach }
  end
end
setup_servers() -- important
-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
-- https://sharksforarms.dev/posts/neovim-rust/
-- nvim_lsp object
local nvim_lsp = require'lspconfig'
-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
local opts = {
  -- automatically set inlay hints (type hints)
  -- There is an issue due to which the hints are not applied on the first
  -- opened file. For now, write to the file to trigger a reapplication of
  -- the hints or just run :RustSetInlayHints.
  -- default: true
  autoSetHints = true,
}
-- require('rust-tools').setup(opts)
require('rust-tools').setup{}
nvim_lsp.go.setup({ on_attach=on_attach })
require 'lsp_signature'.setup()
nvim_lsp.gopls.setup({on_attach=on_attach})
-- Enable diagnosetics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
-- nvim-treesitter settings
require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = { enable = true  },
    highlight_current_scope = { enable = false },
    -- smart_rename = {
    --  enable = true,
    --  keymaps = {
    --    smart_rename = "gB",
    --  },
    --},
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<m-*>",
        goto_previous_usage = "<m-#>",
      },
    },
  },
  ensure_installed = "maintained",
  ignore_install = { },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
    indent = {
      enable = true
    }
  },
  textsubjects = {
      enable = true,
      keymaps = {
          ['.'] = 'textsubjects-smart',
      }
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["at"] = "@comment.outer",
        ["ad"] = "@conditional.outer",
        ["id"] = "@conditional.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "parameter.outer",
        ["ia"] = "parameter.inner",
        ["an"] = "scopename.inner",
        ["as"] = "statement.outer",
      },
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
}
-- zen mode
require("zen-mode").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    width = 0.98, -- width of the Zen window
    height = 0.85, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      signcolumn = "yes", -- disable signcolumn
      number = true, -- disable number column
      relativenumber = true, -- disable relative numbers
      cursorline = true, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
}
-- dim unfocused area.
require("twilight").setup {
 -- https://github.com/folke/twilight.nvim/
 dimming = {
   alpha = 0.20, -- amount of dimming
   -- we try to get the foreground from the highlight groups or fallback color
   -- color = { "Normal", "#ffffff" },
 },
 context = 30, -- amount of lines we will try to show around the current line
 -- treesitter is used to automatically expand the visible text,
 -- but you can further control the types of nodes that should always be fully expanded
 -- expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
 --   "function",
 --   "method",
 --   "table",
 --   "if_statement",
 -- },
 -- exclude = {}, -- exclude these filetypes
}
-- vim-way for diagnose.
-- require("vimway-lsp-diag").init({
    -- debounce_ms = 50, -- default
-- })
--
-- indent blankline
require("indent_blankline").setup {
    -- char = "|",
    buftype_exclude = {"terminal"}
}
-- gitsigns
-- https://github.com/lewis6991/gitsigns.nvim
require('gitsigns').setup{
  numhl = true,
  linehl = false,
  current_line_blame = true,
}
-- autopairs
require('nvim-autopairs').setup{}
local remap = api.nvim_set_keymap
local npairs = require('nvim-autopairs')
-- skip it, if you use another global object
_G.MUtils= {}
gl.completion_confirm_key = ""
MUtils.completion_confirm = function()
  if fn.pumvisible() ~= 0 then
    if fn.complete_info()["selected"] ~= -1 then
      require'completion'.confirmCompletion()
      return npairs.esc("<c-y>")
    else
      api.nvim_select_popupmenu_item(0 , false , false ,{})
      require'completion'.confirmCompletion()
      return npairs.esc("<c-n><c-y>")
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
-- !!!!!!!!!!!!!! LOCAL PLUGINS !!!!!!!!!!!!!!! --
-- local plugins
require('plugs')
