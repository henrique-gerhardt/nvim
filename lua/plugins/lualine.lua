return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 
	    'nvim-tree/nvim-web-devicons',
    	    'folke/noice.nvim', 
    	    'MunifTanjim/nui.nvim',
    },
    config = function()
	    require('lualine').setup {
  options = {
    icons_enabled        = true,
    theme                = 'auto',
    component_separators = { left = '', right = '' },
    section_separators   = { left = '', right = '' },
    always_divide_middle = true,
    globalstatus         = true,
  },
  sections = {
    lualine_a = {
      {
        function() return '' end,
        color     = { fg = '#FFFFFF', gui = 'bold' },
        separator = { left = '', right = '' },
        padding   = { left = 1, right = 1 },
      },
      'mode',
    },
    lualine_b = {
      'branch',
      {
        -- status do Git upstream (ahead/behind)
        function()
          local stats = vim.fn.systemlist('git rev-list --left-right --count @{u}...HEAD')
          if vim.v.shell_error ~= 0 or #stats == 0 then return '' end
          local behind, ahead = unpack(vim.split(stats[1], '%s+'))
          return '↑'..ahead..' ↓'..behind
        end,
        color    = { fg = '#56b6c2' },
        cond     = function() return vim.fn.isdirectory('.git') == 1 end,
        padding  = { left = 1, right = 1 },
      },
      {
        'diff',
        colored    = true,
        symbols    = { added = '+', modified = '~', removed = '-' },
        diff_color = {
          added    = { fg = '#98c379' },
          modified = { fg = '#e5c07b' },
          removed  = { fg = '#e06c75' },
        },
      },
    },
    lualine_c = {
      {
        'filename',
        path            = 1,
        file_status     = true,
        shorting_target = 40,
        symbols         = { modified = '●', readonly = '' },
        fmt             = function(str)
          local icon = require('nvim-web-devicons').get_icon(
            vim.fn.expand('%:t'),
            vim.fn.expand('%:e'),
            { default = true }
          ) or ''
          return (icon and (icon .. ' ')) .. str
        end,
	separator = {right = ""},
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources            = { 'nvim_lsp' },
        sections           = { 'error','warn','info','hint' },
        symbols            = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        colored            = true,
        update_in_insert   = false,
        always_visible     = false,
      },
      {
            require('noice').api.status.command.get,
            cond    = require('noice').api.status.command.has,
            color   = { fg = '#ff9e64' },
            padding = { left = 1, right = 1 },
	    separator = {left = '', right = ''}
      },
      {
        -- indicador de indent (tabs vs spaces)
        function()
          if vim.bo.expandtab then
            return '󱁐 '..vim.bo.shiftwidth
          else
            return '󰌒 '..vim.bo.shiftwidth
          end
        end,
        padding = { left = 1, right = 1 },
      },
      {
        -- contador de ocorrências da busca atual
        function()
          local s = vim.fn.searchcount({ maxcount = 9999 })
          return (s.total > 0 and vim.v.hlsearch == 1)
            and (s.current..'/'..s.total)
            or ''
        end,
        icon    = '',
        cond    = function() return vim.v.hlsearch == 1 end,
        padding = { left = 1, right = 1 },
      },
    },
    lualine_y = { 'location' },
    lualine_z = {
      {
        function() return os.date('%H:%M') end,
        padding = { left = 1, right = 2 },
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
}

    end
}
