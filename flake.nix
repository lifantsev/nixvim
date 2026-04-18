{
    description = "Mark Lifantsev's personal nixvim flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    };

    outputs = { nixpkgs, nixvim, ... }: let
        systems = [ "aarch64-linux" "x86_64-linux" ];
        nixvimConfig = import ./nixvim.nix;
        modules = {
            nixPackage = { pkgs, ... }@args: {
                config = nixvimConfig args;
                options.programs.lifantsev-nixvim = import ./options args;
            };
            homeModule = { pkgs, ... }@args: {
                options.programs.lifantsev-nixvim = import ./options args;
                config = args.lib.mkIf args.config.programs.lifantsev-nixvim.enable {
                    programs.nixvim = nixvimConfig args // {
                        enable = true;
                    };
                };
            };
        };
    in {
        packages = nixpkgs.lib.genAttrs systems (system: {
            default = nixvim.legacyPackages.${system}.makeNixvim {
                imports = [modules.nixPackage];
            };
            # minimal = nixvim.legacyPackages.${system}.makeNixvim {
            #     imports = [
            #         (module { env = "nixPackage"; })
            #         # TODO make changes other than making it gruvbox
            #         { programs.lifantsev-nixvim.colorscheme = "gruvbox"; }
            #     ];
            # };
        });

        homeManagerModules.default = {
            imports = [
                nixvim.homeModules.nixvim
                modules.homeModule
            ];
        };

        nixConfig = { # use the cachix binary cache
            extra-substituters = [ "https://lifantsev-nixvim.cachix.org" ];
            extra-trusted-public-keys = [ "lifantsev-nixvim.cachix.org-1:YrToDOQcRnfUaXmkCBgF4nN4Znsvq/tCCX1pISSmFm0=" ];
        };
    };
}
