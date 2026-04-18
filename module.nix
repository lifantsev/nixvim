env: { lib, config, options, pkgs, ... }@arguments: let
    cfg = config.programs.lifantsev-nixvim;
    args = arguments // { inherit cfg; };
    nixvim = import ./nixvim.nix args;
in {
    config = if env == "nixPackage"
             then nixvim
             else if env == "homeManagerModule"
             then lib.mkIf cfg.enable { programs.nixvim = { enable = true; } // nixvim; }
             else {};

    options.programs.lifantsev-nixvim = import ./options args;
}
