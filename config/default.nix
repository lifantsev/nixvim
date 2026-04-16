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

    pluginFiles = filesIn ./plugin; # plugins that have nixvim module
    externpluginFiles = filesIn ./plugin/extern; # plugins not managed by nixvim
    custompluginFiles = filesIn ./plugin/custom; # custom plugins made just for this config
    bindFiles = filesIn ./binds; # kemymap definitions
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

    # configure ./plugin's using nixvim their modules
    plugins = lib.mergeAttrsList (map (file: { ${stemOf file} = (import file args).plugin;}) pluginFiles); # TODO use genAttrs'

    # install ./plugin/extra's based on filename
    extraPlugins = map (file: pkgs.vimPlugins.${stemOf file}) externpluginFiles;

    # take binds from ./binds
    # ./plugin's may define remap
    # ./plugin/extra's may also define remap
    keymaps = lib.lists.concatLists ( (map (file: import file args) bindFiles) 
                                   ++ (map (file: (import file args).remap or []) pluginFiles)
                                   ++ (map (file: if lib.hasSuffix ".nix" file then (import file args).remap or [] else []) externpluginFiles) );

    # this needs to be pre
    # ./plugin/extra's may define lua or they can just be a lua file
    # ./plugin's may define lua
    # ./extralua is appended
    extraConfigLuaPre = lib.concatStrings (map (file: if lib.hasSuffix ".nix" file then (import file args).lua else builtins.readFile file) externpluginFiles)
                      + lib.concatStrings (map (file: (import file args).lua or "") pluginFiles)
                      + lib.concatStrings (map builtins.readFile custompluginFiles);

    # just add highlight definitions to the end of init.lua
    extraConfigLuaPost = import ./highlights.nix cfg.colors;
}
