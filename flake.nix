{
    description = "Mark Lifantsev's personal nixvim flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        nixvim.url  = "github:nix-community/nixvim/nixos-25.11";
    };

    outputs = { nixpkgs, nixvim, ... }: let
        systems = [ "aarch64-linux" "x86_64-linux" ];
        module = import ./module;
        defaultColors = import ./colors.nix;
        defaultColorscheme = "catppuccin";
    in {
        nixConfig = {
            extra-substituters = [ "https://lifantsev-nixvim.cachix.org" ];
            extra-trusted-public-keys = [ "lifantsev-nixvim.cachix.org-1:YrToDOQcRnfUaXmkCBgF4nN4Znsvq/tCCX1pISSmFm0=" ];
        };

        packages = nixpkgs.lib.genAttrs systems (system: {
            default = nixvim.legacyPackages.${system}.makeNixvimWithModule {
                inherit module;
                pkgs = nixpkgs.legacyPackages.${system};
                extraSpecialArgs = {
                    colors = defaultColors;
                    colorscheme = defaultColorscheme;
                };
            };
        });

        homeManagerModules.default = { pkgs, lib, config, ... }: {
            imports = [ nixvim.homeModules.nixvim ];

            options.programs.lifantsev-nixvim = {
                enable = lib.mkOption {
                    description = "whether to configure and enable the nixvim module";
                    default = false;
                    type = lib.types.bool;
                };

                colorscheme = lib.mkOption {
                    description = "name of the colorscheme to use";
                    default = defaultColorscheme;
                    type = lib.types.str;
                    example = "gruvbox";
                };

                colors = lib.mkOption {
                    description = "hex strings to use for vim highlights not covered by colorscheme";
                    default = {};
                    defaultText = "catpuccin mocha colorscheme";
                    example = {
                        bg = "#282828";
                        blue = "#83a598";
                    };
                    type = lib.types.submodule {
                        options = lib.mapAttrs (_: default: lib.mkOption {
                            type = lib.types.str;
                            inherit default;
                        }) defaultColors;
                    };
                };
            };

            config = let cfg = config.programs.lifantsev-nixvim;
            in lib.mkIf cfg.enable
            {
                programs.nixvim = { enable = true; } // module {
                    inherit pkgs lib;
                    colors = cfg.colors;
                    colorscheme = cfg.colorscheme;
                };
            };
        };
    };
}
