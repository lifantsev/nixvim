{ lib, pkgs, config, ... }: let
    cfg = config.programs.lifantsev-nixvim;
    features = lib.filterAttrs (name: attrs: attrs.enable && name != "toggleterm") cfg.features;

    lua = postpre: features: features
            |> lib.attrValues
            |> map (a: a.lua.${postpre})
            |> lib.concatStringsSep "\n";
in {
    globals.mapleader = cfg.keys.leader;

    colorschemes.${cfg.colorscheme} = {
        enable = true;
        settings = cfg.colorschemeSettings;
    };

    keymaps = features
                |> lib.attrValues
                |> map (a: a.keymaps)
                |> lib.lists.concatLists;

    extraConfigLuaPre = lua "pre" features;
    extraConfigLuaPost = lua "post" features;

    plugins = features
                |> lib.filterAttrs (featname: a: a.nixvimPlugin != {})
                |> lib.mapAttrs (f: a: a.nixvimPlugin);

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
