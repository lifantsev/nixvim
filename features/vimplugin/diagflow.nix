{ ... }: {
    vimPlugin = "diagflow-nvim";
    lua.post = /*lua*/ ''
        require("diagflow").setup({
            enable = true,
            scope = 'line',
            padding_right = 1,
            -- show_borders = true,
        })
    '';
}
