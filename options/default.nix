{ lib, config, ... }@arguments: let 
    cfg = config.programs.lifantsev-nixvim;
    args = arguments // { inherit cfg; };
in {
    enable = lib.mkEnableOption "configuration of nixvim module";

    wipe = lib.mkEnableOption "setting all defaults to empty strings & attrsets";

    colorscheme = lib.mkOption {
        description = "name of the nixvim colorscheme to use";
        type = lib.types.str;
        default = if !cfg.wipe then "catppuccin" else "";
        example = "gruvbox";
    };

    colorschemeSettings = lib.mkOption {
        description = "settings attrs to pass to nixvim's colorschemes.<name>.settings";
        type = lib.types.attrs;
        default = if !cfg.wipe then {
            transparent_background = true;
            float.transparent = true;
        } else {};
    };

    keys     = if !cfg.wipe then import ./keys.nix args else {};
    colors   = if !cfg.wipe then import ./colors.nix args else {};
    features = if !cfg.wipe then import ./features.nix args else {};
}
