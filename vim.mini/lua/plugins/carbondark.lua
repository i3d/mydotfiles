local gl = require('galaxyline')
local condition = require('galaxyline.condition')

-- quitedark
local colors = {
  bg = '#0E0E0E',
  bg_dim = '#070707',
  bg_light = '#131313',
  black = '#333333',
  white = '#FAFAFA',
  gray = '#4b4c4b',
  red = '#575757',
  green = '#CACACA',
  yellow = '#FAFF00',
  blue = '#737373',
  purple = '#412A4d', -- tweaked to match custom color
  teal = '#9F9F9F',
}

local function mode_alias(m)
  local alias = {
    n = 'N',
    i = 'I',
    c = 'C',
    C = 'C',
    R = 'R',
    t = 'T',
    [''] = 'VB',
    V = 'VL',
    v = 'V',
    ['r?'] = ':CONFIRM',
    rm     = '--MORE',
    Rv     = 'R&V',
    s      = 'S',
    S      = 'S',
    ['r']  = 'HIT-ENTER',
    [''] = 'SELECT',
    ['!']  = 'SH',
  }

  return alias[m] or ''
end

local function mode_color(m)
  local mode_colors = {
    normal =  colors.gray,
    insert =  colors.teal,
    visual =  colors.blue,
    replace =  colors.purple,
    block = colors.yellow,
    line = colors.green
  }

  local color = {
    n = mode_colors.normal,
    i = mode_colors.insert,
    c = mode_colors.replace,
    R = mode_colors.replace,
    t = mode_colors.insert,
    [''] = mode_colors.block,
    V = mode_colors.line,
    v = mode_colors.visual,
  }

  return color[m] or colors.bg_light
end

-- disable for these file types
gl.short_line_list = { 'startify', 'nerdtree', 'term', 'fugitive', 'NvimTree' }

gl.section.left[1] = {
  ViModeIcon = {
    separator = '  ',
    separator_highlight = {colors.green, colors.gray},
    highlight = {colors.bg, colors.green},
    provider = function() return "   " end,
  }
}

gl.section.left[2] = {
  CWD = {
    separator = '  ',
    separator_highlight = function()
      return {colors.gray, condition.buffer_not_empty() and colors.bg_dim or colors.bg}
    end,
    highlight = {colors.bg, colors.gray},
    provider = function()
      local dirname = vim.fn.fnamemodify(vim.fn.fnamemodify(vim.fn.expand('%'), ':p:h'), ':t')
      return ' ' .. dirname .. ' '
    end,
  }
}

gl.section.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {colors.gray, colors.bg_dim},
  }
}

gl.section.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.teal, colors.bg_dim},
    separator_highlight = {colors.bg_dim, colors.bg_dim},
    separator = '',
  }
}

gl.section.left[5] = {
    CitcClient = {
        -- icon = '  ',
        icon = ' ',
        highlight = {colors.yellow, colors.bg_dim},
        provider = function()
            local path = vim.fn.fnamemodify(vim.fn.expand('%'), ':p:h')
            if not path.find(path, "google3") then return '' end
            local tail = vim.fn.substitute(path, ".*" .. vim.fn.getenv("USER") .. "/", "","g")
            return vim.fn.substitute(tail, "/google3.*", "", "g") -- add this if no [6] .. ' '
        end,
        separator = '  ',
        separator_highlight = {colors.bg_dim, colors.bg_dim},  -- change bg to colors.bg if no [6]
    }
}

local revcl_t = {}
local function revcl()
  if #revcl_t > 0 then return nil end
  local hginfo = vim.fn.system("hgll -r . | grep -v 'p4head' | grep 'cl/'")  -- the expensive call
  if hginfo == nil or hginfo == '' then return nil end
  local t = {}
  for w in string.gmatch(hginfo, "%S+") do
    table.insert(t, w)
  end
  -- -- example: @ 424b0bfe jimxu cl/391835689 tip <exported as http://url>
  -- -- ^    ^       ^       ^         ^      ^
  -- -- br   rev    owner    cl       st      url
  -- -- we just need #2 and #4.
  table.insert(revcl_t, t[2])
  table.insert(revcl_t, t[4])
  return nil
end
gl.section.left[6]= {
 HgInfo = {
   icon = ' ',
   provider = function()
    revcl()
    if #revcl_t <= 0 then return '' end
    return revcl_t[1] .. '::' .. revcl_t[2] .. ' '
   end,
   highlight = {colors.gray, colors.bg_dim},
   separator = '  ',
   separator_highlight = {colors.bg_dim, colors.bg},
 }
}

gl.section.left[7] = {
  DiffAdd = {
    icon = '  ',
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    highlight = {colors.green, colors.bg},
  }
}

gl.section.left[8] = {
  DiffModified = {
    icon = '  ',
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    highlight = {colors.gray, colors.bg},
  }
}

gl.section.left[9] = {
  DiffRemove = {
    icon = '  ',
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    highlight = {colors.red, colors.bg},
  }
}

gl.section.left[10] = {
  CocStatus = {
    highlight = {colors.gray, colors.bg},
    provider = function()
    return vim.fn['coc#status']()
        :gsub('\u{274c}', '\u{f06a}')         -- 
        :gsub('\u{26a0}\u{fe0f}', '\u{f071}') -- 
    end
  }
}

gl.section.left[11] = {
  CocFunction = {
    icon = 'λ ',
    highlight = {colors.gray, colors.bg},
    provider = function()
      local has_func, func_name = pcall(vim.api.nvim_buf_get_var, 0, 'coc_current_function')
      if not has_func then return '' end
    return func_name or ''
    end,
  }
}

local gps = require('nvim-gps')
gl.section.left[12]= {
	nvimGPS = {
		provider = function()
			return gps.get_location()
		end,
		condition = function()
			return gps.is_available()
		end
	}
}


-- provided by gps.
-- gl.section.right[1] = {
  -- VistaPlugin = {
    -- highlight = {colors.gray, colors.bg},
    -- provider = 'VistaPlugin',
    -- separator = ' '
  -- }
-- }

gl.section.right[2] = {
  FileType = {
    highlight = {colors.gray, colors.bg},
    provider = function()
      local buf = require('galaxyline.provider_buffer')
      return string.lower(buf.get_buffer_filetype())
    end,
  }
}

gl.section.right[3] = {
  GitBranch = {
    icon = ' ',
    separator = '  ',
    condition = condition.check_git_workspace,
    highlight = {colors.teal, colors.bg},
    provider = 'GitBranch',
  }
}

gl.section.right[4] = {
  FileLocation = {
    icon = ' ',
    separator = ' ',
    separator_highlight = {colors.bg_dim, colors.bg},
    highlight = {colors.gray, colors.bg_dim},
    provider = function()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')

      if current_line == 1 then
        return 'Top'
      elseif current_line == total_lines then
        return 'Bot'
      end

      local percent, _ = math.modf((current_line / total_lines) * 100)
      return '' .. percent .. '% '
    end,
  }
}
gl.section.right[5]= {
  LineColumn = {
    provider = 'LineColumn',
    condition = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
      end,
    highlight = {colors.gray, colors.bg_dim},
  }
}
gl.section.right[6]= {
  FileSize = {
    provider = 'FileSize',
    condition = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
      end,
    icon = '    ',
    highlight = {colors.gray, colors.bg_dim},
    -- separator = ' ',
    -- separator_highlight = {colors.bg_dim, colors.bg},
  }
}

vim.api.nvim_command('hi GalaxyViModeReverse guibg=' .. colors.bg_dim)
gl.section.right[7] = {
  ViMode = {
    icon = function()
        local icons = {
            n      = ' ',
            rm     = ' ',
            s      = ' ',
            S      = ' ',
            ['^S'] = ' ',
            i      = ' ',
            c      = 'ﲵ ',
            V      = ' ',
            [''] = ' ',
            v      = ' ',
            C      = 'ﲵ ',
            R      = '﯒ ',
            Rv     = '﯒ ',
            ['r']  = '﯒ ',
            t      = ' ',
            ['!']  = ' ',
        }
        return icons[vim.fn.mode()]
    end,
    separator = ' ',
    separator_highlight = 'GalaxyViModeReverse',
    highlight = {colors.bg, mode_color()},
    provider = function()
      local m = vim.fn.mode() or vim.fn.visualmode()
      local mode = mode_alias(m)
      local color = mode_color(m)
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. color)
      vim.api.nvim_command('hi GalaxyViModeReverse guifg=' .. color)
      return ' ' .. mode .. ' '
    end,
  }
}
