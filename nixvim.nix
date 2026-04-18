# TODO set up cmp and luasnip (completion in general)
# TODO set up DAP
# TODO set up lsp keybinds: goto def, list ref, etc
# TODO look into plugin for building project using vim bind (or write it)
# TODO add lsp diagnostic count to bar

# TODO change markdown highlight colors to something more pleasing
# TODO per filetype wrapping

{ lib, pkgs, config, ... }: let
    cfg = config.programs.lifantsev-nixvim;
    features = lib.filterAttrs (name: attrs: attrs.enable) cfg.features;
in {
    globals.mapleader = " ";

    colorschemes.${cfg.colorscheme} = {
        enable = true;
        settings = cfg.colorschemeSettings;
    };

    keymaps = lib.lists.concatLists (map (f: f.keymaps) (lib.attrValues features));
    extraConfigLuaPre = lib.concatStrings (map (f: f.lua.pre) (lib.attrValues features));
    extraConfigLuaPost = lib.concatStrings (map (f: f.lua.post) (lib.attrValues features));
    plugins = lib.mapAttrs (k: v: v.nixvimPlugin)
                  (lib.filterAttrs (k: v: v.nixvimPlugin != {}) features);
    extraPlugins = map (name: pkgs.vimPlugins.${name})
                       (lib.attrNames (lib.filterAttrs (f: a: a.vimPlugin) features));
}
