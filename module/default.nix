{ env }: { lib, config, options, pkgs, ... }@arguments: let
    cfg = config.programs.lifantsev-nixvim;
    args = arguments // { inherit cfg; };
    vimconfig = import ../config args;
in {
    config = if env == "nixPackage"
             then vimconfig
             else if env == "homeManagerModule"
             then lib.mkIf cfg.enable { programs.nixvim = { enable = true; } // vimconfig; }
             else {};

    options.programs.lifantsev-nixvim = {
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

        features = import ./features.nix args;
        colors = import ./colors.nix args;
    };
}
