# lspconfig
{ ... }: {
    plugin.enable = true;

    plugin.servers = {
        lua_ls.enable = true; # lua
        nixd.enable   = true; # nix
        bashls.enable = true; # sh
        ts_ls.enable  = true; # js & ts
        jsonls.enable = true; # json
        pylsp.enable  = true; # python

        lua_ls.settings.diagnostics.globals = [ "vim" ];

        pylsp.settings.plugins = {
            pyflakes.enabled = true;
            pycodestyle.enabled = true;
        };
    };

    lua.pre = /*lua*/ ''
        vim.o.signcolumn = "yes"
    '';
}
