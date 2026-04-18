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

    mkFeature = file: let
        ftype = ftypeOf file;
        attrs = if ftype=="nix" then
                    (import file args)
                else if ftype=="lua" then
                    { luapre = builtins.readFile file; }
                else {};
    in {
        enable = true;
        keymaps = attrs.keymaps or [];

        lua = {
            pre = attrs.lua.pre or "";
            post = attrs.lua.post or "";
        };

        vimPlugin = lib.path.hasPrefix ./plugin/vim file;
        
        nixvimPlugin = attrs.plugin or {};
    };

    features = lib.mergeAttrsList (map (f: { ${stemOf f} = mkFeature f; }) (
        (filesIn ./keymaps) ++
        (filesIn ./plugin) ++
        (filesIn ./vimplugin) ++
        (filesIn ./other))
    ); # TODO filter out features that arent enabled
in {
    globals.mapleader = " ";

    colorschemes.${cfg.colorscheme} = {
        enable = true;
        settings = cfg.colorschemeSettings;
    };

    keymaps = lib.lists.concatLists (map (f: f.keymaps) (lib.attrValues features));
    extraConfigLuaPre = lib.concatStrings (map (f: f.lua.pre) (lib.attrValues features));
    plugins = lib.mapAttrs (k: v: v.nixvimPlugin)
                  (lib.filterAttrs (k: v: v.nixvimPlugin != {}) features);
    extraPlugins = map (name: pkgs.vimPlugins.${name})
                       (lib.attrNames (lib.filterAttrs (f: a: a.vimPlugin) features));
}
