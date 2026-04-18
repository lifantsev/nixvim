# TODO set up cmp and luasnip (completion in general)
# TODO set up DAP
# TODO set up lsp keybinds: goto def, list ref, etc
# TODO look into plugin for building project using vim bind (or write it)
# TODO add lsp diagnostic count to bar

# TODO change markdown highlight colors to something more pleasing
# TODO per filetype wrapping

{ lib, pkgs, cfg, ... }@args: let
    stemOf = file: let
        matches = builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf file);
    in if matches == null then builtins.baseNameOf file else builtins.elemAt matches 0;

    filesIn = path: let
        fileset = lib.attrsets.filterAttrs (n: v: v == "regular") (builtins.readDir path);
    in map (name: path + "/${name}") (builtins.attrNames fileset);

    ftypeOf = file: if (lib.hasSuffix ".nix" file) then "nix" else if (lib.hasSuffix ".lua" file) then "lua" else "";

    # feature = {
    #     enable = true;
    #     name = "lualine"
    #     keymaps = [];
    #     lua.pre = "";
    #     lua.post = "";
    #     vimPlugin = false;
    #     nixvimPlugin = {
    #         settings = { ... };
    #         servers = { ... };
    #     };
    # };

    # type is one of vimplug, nixvimplug, custom
    # TODO maybe allow declaring dependencies between features? like noice -> nui
    mkFeature = file: let
        ftype = ftypeOf file;
        attrs = if ftype=="nix" then
                    (import file args)
                else if ftype=="lua" then
                    { luapre = builtins.readFile file; }
                else {};
    in {
        enable = true;
        name = stemOf file;
        keymaps = attrs.keymaps or [];

        lua = {
            pre = attrs.lua.pre or "";
            post = attrs.lua.post or "";
        };

        vimPlugin = lib.path.hasPrefix ./plugin/vim file;
        
        nixvimPlugin = attrs.plugin or {};
    };

    # TODO add ./binds
    features = map mkFeature ( (filesIn ./binds) ++ (filesIn ./plugin/nixvim) ++ (filesIn ./plugin/vim) ++ (filesIn ./plugin/custom));
in {
    opts = (import ./options.nix);
    globals.mapleader = " ";
    globals.loaded_matchit = 1; # disable loading of an annoying plugin

    colorschemes.${cfg.colorscheme} = {
        enable = true;
        settings = {
            transparent_background = true;
            float.transparent = true;
        };
    };

    # configure nixvim builtin plugins
    plugins = lib.mergeAttrsList (map (f: { ${f.name} = f.nixvimPlugin; })
                                      (lib.filter (f: f.nixvimPlugin != {}) features) );

    # install ./plugin/extra's based on filename
    extraPlugins = map (f: pkgs.vimPlugins.${f.name})
                       (lib.filter (f: f.vimPlugin) features);

    # take binds from ./binds
    # ./plugin's may define remap
    # ./plugin/extra's may also define remap
    keymaps = lib.lists.concatLists (map (f: f.keymaps) features);

    # this needs to be pre
    # ./plugin/extra's may define lua or they can just be a lua file
    # ./plugin's may define lua
    # ./extralua is appended
    extraConfigLuaPre = lib.concatStrings (map (f: f.lua.pre) features);

    # just add highlight definitions to the end of init.lua
    extraConfigLuaPost = import ./highlights.nix cfg.colors;
}
