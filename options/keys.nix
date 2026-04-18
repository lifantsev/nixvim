{ lib, cfg, ... }: lib.mkOption {
    description = "settings used by the default keymap features; this option is noop if you disable those";

    type = lib.types.submodule { options = {
        directional = lib.mkOption {
            description = "keys to use for directional keymaps (useful if you don't use qwerty)";
            type = lib.types.submodule { options = {
                left  = lib.mkOption { default = "h"; };
                down  = lib.mkOption { default = "j"; };
                up    = lib.mkOption { default = "k"; };
                right = lib.mkOption { default = "l"; };
            };};
            example = {
                left  = "n";
                up    = "a";
                down  = "i";
                right = "o";
            };
            default = {};
        };

        hjkl = lib.mkOption {
            description = "what to bind hjkl to (relevant if you set `keys.directional`). by default the keys are just swapped one to one, set this if you want to reshuffle them";
            type = lib.types.submodule { options = {
                h = lib.mkOption { default = cfg.keys.directional.left; };
                j = lib.mkOption { default = cfg.keys.directional.down; };
                k = lib.mkOption { default = cfg.keys.directional.up; };
                l = lib.mkOption { default = cfg.keys.directional.right; };
            };};
            example = {
                h = cfg.keys.directional.down;
                j = cfg.keys.directional.left;
                k = cfg.keys.directional.up;
                l = cfg.keys.directional.right;
            };
            default = {};
        };
    };};
    default = {};
}
