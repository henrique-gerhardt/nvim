return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
	require('lualine').setup {
  options = {
    icons_enabled = true,               -- habilita ícones
    theme = 'auto',                     -- detecta tema automaticamente
    component_separators = { left = '', right = '' },
    section_separators   = { left = '', right = '' },
    always_divide_middle = true,
    globalstatus = true,                -- linha de status global
  },
  sections = {
    -- ┌─────────── Lado esquerdo ────────────┐
    lualine_a = {
      -- 1. ícone do Vim
      { function() return '' end,
        color = { fg = '#FFFFFF', gui = 'bold' },
	separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      },
      -- 2. modo atual (colorido automaticamente)
      'mode',
    },
    lualine_b = {
      -- 3. branch git
      'branch',
      -- 4. diff com cores (verde/laranja/vermelho)
      {
        'diff',
        colored = true,
        symbols = { added = '+', modified = '~', removed = '-' },
        diff_color = {
          added    = { fg = '#98c379' },  -- verde
          modified = { fg = '#e5c07b' },  -- laranja
          removed  = { fg = '#e06c75' },  -- vermelho
        },
      },
    },
    -- 5. filename + caminho relativo + ícone de arquivo
    lualine_c = {
      {
        'filename',
        path = 1,             -- 0 = nome apenas, 1 = caminho relativo
        file_status = true,
        shorting_target = 40, -- abrevia se muito longo
        symbols = { modified = '●', readonly = '' },
        fmt = function(str)
          local icon = require('nvim-web-devicons').get_icon(
            vim.fn.expand('%:t'), 
            vim.fn.expand('%:e'), 
            { default = false }
          )
          return (icon and (icon .. ' ')) .. str
        end,
      },
    },
    -- └─────────── Meio (vazio) ────────────┘

    -- ┌─────────── Lado direito ─────────────┐
    lualine_x = {
      -- 6. erros/LSP (só aparece se houver)
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
    },
    -- 7. linha:coluna
    lualine_y = { 'location' },
    -- 8. hora atual
    lualine_z = {
      { function() return os.date('%H:%M') end,
        padding = { left = 1, right = 2 },
      },
    },
    -- └─────────────────────────────────────┘
  },
  inactive_sections = {
    -- versões “inativas” da barra
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
