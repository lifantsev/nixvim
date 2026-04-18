{ lib, cfg, ... }@args: let # cfg passed thru
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
in lib.mergeAttrsList (map (f: { ${stemOf f} = mkFeature f; }) (
    (filesIn ./keymaps) ++
    (filesIn ./plugin) ++
    (filesIn ./vimplugin) ++
    (filesIn ./other))
)
