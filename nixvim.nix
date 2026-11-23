{ lib, pkgs, config, ... }: let
    cfg = config.programs.lifantsev-nixvim;
    features = lib.filterAttrs (name: attrs: attrs.enable) cfg.features;
in {
    globals.mapleader = cfg.keys.leader;

    colorschemes.${cfg.colorscheme} = {
        enable = true;
        settings = cfg.colorschemeSettings;
    };

    keymaps = lib.lists.concatLists (map (f: f.keymaps) (lib.attrValues features));

    extraConfigLuaPre = lib.concatStringsSep "\n" (map (f: f.lua.pre) (lib.attrValues features));
    extraConfigLuaPost = lib.concatStringsSep "\n" (map (f: f.lua.post) (lib.attrValues features));

    plugins = lib.mapAttrs (k: v: v.nixvimPlugin)
        (lib.filterAttrs (k: v: v.nixvimPlugin != {}) features);

    extraPlugins = (features
                    |> lib.filterAttrs (f: a: a.vimPlugin != "")
                    |> lib.attrValues
                    |> map (a: pkgs.vimPlugins.${a.vimPlugin}))
                ++ (features
                    |> lib.filterAttrs (f: a: a.extraPlugin != {})
                    |> lib.mapAttrsToList (featname: attrs: pkgs.vimUtils.buildVimPlugin {
                            name = featname;
                            src = pkgs.fetchFromGitHub attrs.extraPlugin;
                        }));
}
