colors: with colors; /*lua*/ ''
    vim.api.nvim_set_hl(0, 'FloatTitle', { fg = '${blue}' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '${mg}' })

    vim.api.nvim_set_hl(0, 'MiniFilesTitleFocused', { fg = '${blue}', bold = true; })
    vim.api.nvim_set_hl(0, 'MiniFilesBorderModified', { fg = '${red}' })

    vim.api.nvim_set_hl(0, 'LeapLabel', { fg = '${purple}', bg = '${bg}', bold = true; })

    vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { fg = '${mg}' })
    vim.api.nvim_set_hl(0, 'NoiceCmdlineIconSearch', { link = "NoiceCmdlineIcon" })
    vim.api.nvim_set_hl(0, 'NoiceFormatConfirm', { bg = 0 })
    vim.api.nvim_set_hl(0, 'NoiceFormatConfirmDefault', { bg = 0} )
''
