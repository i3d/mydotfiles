local gl = require('galaxyline')
local condition = require('galaxyline.condition')

-- matrix
local colors = {
  bg = '#091013',
  bg_dim = '#18282e',
  bg_light = '#333333',
  black = '#333333',
  white = '#507350',
  gray = '#5E7F58',
  red = '#003c1f',
  green = '#90d762',
  yellow = '#e2e500',
  blue = '#00FF87',
  purple = '#412A4d', -- tweaked to match custom color
  teal = '#C1FF8A',
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
    separator_highlight = {colors.bg_dim, colors.bg},
    separator = '  ',
  }
}

gl.section.left[5] = {
  DiffAdd = {
    icon = '  ',
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    highlight = {colors.green, colors.bg},
  }
}

gl.section.left[6] = {
  DiffModified = {
    icon = '  ',
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    highlight = {colors.gray, colors.bg},
  }
}

gl.section.left[7] = {
  DiffRemove = {
    icon = '  ',
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    highlight = {colors.red, colors.bg},
  }
}

gl.section.left[8] = {
  CocStatus = {
    highlight = {colors.gray, colors.bg},
    provider = function()
      return vim.fn['coc#status']()
        :gsub('\u{274c}', '\u{f06a}')         -- 
        :gsub('\u{26a0}\u{fe0f}', '\u{f071}') -- 
    end
  }
}

gl.section.left[9] = {
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
gl.section.left[10]= {
	nvimGPS = {
		provider = function()
			return gps.get_location()
		end,
		condition = function()
			return gps.is_available()
		end
	}
}

gl.section.right[1] = {
  FileType = {
    highlight = {colors.gray, colors.bg},
    provider = function()
      local buf = require('galaxyline.provider_buffer')
      return string.lower(buf.get_buffer_filetype())
    end,
  }
}

gl.section.right[2] = {
  GitBranch = {
    icon = ' ',
    separator = '  ',
    condition = condition.check_git_workspace,
    highlight = {colors.teal, colors.bg},
    provider = 'GitBranch',
  }
}

gl.section.right[3] = {
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
      return '' .. percent .. '%'
    end,
  }
}
gl.section.right[4]= {
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

gl.section.right[5] = {
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
