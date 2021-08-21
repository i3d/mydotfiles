local execute = vim.api.nvim_command
local fn = vim.fn

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
  use "terrortylor/nvim-comment"
end)

require('nvim_comment').setup()

---- packer packages.




-- require('plugins') " no include this would make both lunar and native works.
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
	}
  },
}
require('telescope').load_extension('fzf')

-- ----------------------------------------------

-- Color table for highlights
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef';
  red      = '#ec5f67';
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are gona use lualine_c and lualine_x as left and
      -- right section both are highlighted by c theme .
      -- So we are just setring default looks o ststusline
      normal = { c = {fg = colors.fg, bg = colors.bg}},
      inactive = { c = {fg = colors.fg, bg = colors.bg}}
    },
  },
  sections = {
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {}
}

-- Inserts a component in lualine_c ot left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
 function() return '▊' end,
 color = {fg = colors.blue}, -- Sets highlighting of component
 left_padding = 0 -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    -- auto change color according the vim mode
    local mode_color = {
      n      = colors.red,
      i      = colors.green,
      v      = colors.blue,
      [''] = colors.blue,
      V      = colors.blue,
      c      = colors.magenta,
      no     = colors.red,
      s      = colors.orange,
      S      = colors.orange,
      [''] = colors.orange,
      ic     = colors.yellow,
      R      = colors.violet,
      Rv     = colors.violet,
      cv     = colors.red,
      ce     = colors.red,
      r      = colors.cyan,
      rm     = colors.cyan,
      ['r?'] = colors.cyan,
      ['!']  = colors.red,
      t      = colors.red
    }
    vim.api.nvim_command('hi! LualineMode guifg='..mode_color[vim.fn.mode()] .. " guibg="..colors.bg)
    return ''
  end,
  color = "LualineMode",
  left_padding = 0,
}

ins_left {
  -- filesize component
  function()
    local function format_file_size(file)
      local size = vim.fn.getfsize(file)
      if size <= 0 then return '' end
      local sufixes = {'b', 'k', 'm', 'g'}
      local i = 1
      while size > 1024 do
        size = size / 1024
        i = i + 1
      end
      return string.format('%.1f%s', size, sufixes[i])
    end
    local file = vim.fn.expand('%:p')
    if string.len(file) == 0 then return '' end
    return format_file_size(file)
  end,
  condition = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  condition = conditions.buffer_not_empty,
  color = {fg = colors.magenta, gui = 'bold'},
}

ins_left {'location'}

ins_left {
  'progress',
  color = {fg = colors.fg, gui = 'bold'},
}

ins_left {
  'diagnostics',
  sources = {'nvim_lsp'},
  symbols = {error = ' ', warn = ' ', info= ' '},
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan,
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number gretter then 2
ins_left {function() return '%=' end}

ins_left {
  -- Lsp server name .
  function ()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return msg end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = {fg = colors.cyan, gui = 'bold'}
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  upper = true, -- I'm not sure why it's uper case either ;)
  condition = conditions.hide_in_width,
  color = {fg = colors.green, gui = 'bold'}
}

ins_right {
  'fileformat',
  upper = true,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = {fg = colors.green, gui='bold'},
}

ins_right {
  'branch',
  icon = '',
  condition = conditions.check_git_workspace,
  color = {fg = colors.violet, gui = 'bold'},
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = {added= ' ', modified= '柳 ', removed= ' '},
  color_added = colors.green,
  color_modified = colors.orange,
  color_removed = colors.red,
  condition = conditions.hide_in_width
}

ins_right {
  function() return '▊' end,
  color = {fg = colors.blue},
  right_padding = 0,
}

-- Now don't forget to initialize lualine
-- lualine.setup(config)
-- require('lualine').setup {
--  theme = 'tokyonight'
-- }
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
