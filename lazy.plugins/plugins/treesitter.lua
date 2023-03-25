return {
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-textobjects',
  'RRethy/nvim-treesitter-textsubjects',
  'nvim-treesitter/nvim-treesitter-refactor',
  -- { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },

  config = function()
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
      -- ensure_installed = "maintained",
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
  end
}
