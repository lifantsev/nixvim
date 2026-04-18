{ lib, config, ... }@arguments: let 
    cfg = config.programs.lifantsev-nixvim;
    args = arguments // { inherit cfg; };
in {
    enable = lib.mkEnableOption "configuration of nixvim module";

    colorscheme = lib.mkOption {
        description = "name of the nixvim colorscheme to use";
        type = lib.types.str;
        default = "catppuccin";
        example = "gruvbox";
    };

    colorschemeSettings = lib.mkOption {
        description = "settings attrs to pass to nixvim's colorschemes.<name>.settings";
        type = lib.types.attrs;
        default = {
            transparent_background = true;
            float.transparent = true;
        };
    };

    keys = import ./keys.nix args;
    features = import ./features.nix args;
    colors = import ./colors.nix args;
}
