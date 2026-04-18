{ env }: { pkgs, lib, config, ... }: let
    cfg = config.programs.lifantsev-nixvim;
    vimconfig = import ../config { inherit pkgs lib cfg; };
in {
    config = if env == "nixPackage"
             then vimconfig
             else if env == "homeManagerModule"
             then lib.mkIf cfg.enable { programs.nixvim = { enable = true; } // vimconfig; }
             else {};

    options.programs.lifantsev-nixvim = {
        enable = lib.mkOption {
            description = "whether to configure and enable the nixvim module";
            type = lib.types.bool;
            default = false;
        };

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

        # features = lib.mkOption {
        #     description = "a blacklist (or whitelist) filter for what features to enable";
        #     defaultText = "blacklist no plugins";
        #     example = {
        #         whitelist = true;
        #         list = [ "auto-save" ];
        #     };
        #     type = lib.types.submodule {
        #         options = {
        #             whitelist = lib.mkOption {
        #                 description = "whether to treat the plugin list as a whitelist instead of blacklist";
        #                 type = lib.types.bool;
        #                 default = false;
        #             };

        #             list = lib.mkOption {
        #                 # TODO make it clear what these names are
        #                 description = "list of plugin names to blacklist (or whitelist)";
        #                 type = lib.types.listOf lib.types.str;
        #                 default = [];
        #                 example = [ "lsp" ];
        #             };

        #             # extra = lib.mkOption {
        #             #     type = lib.types.listOf lib.types.submodule {
        #             #         enable = "";
        #             #         keymaps = "";

        #             #     };
        #             # };
        #         };
        #     };
        #     default = {};
        # };

        colors = lib.mkOption {
            description = "hex strings to use for vim highlights not covered by colorscheme";
            defaultText = "catpuccin mocha colorscheme";
            example = {
                bg = "#282828";
                mg = "#665c54";
                fg = "#fbf1c7";

                t0 = "#282828";
                t1 = "#3c3836";
                t2 = "#504945";
                t3 = "#665c54";
                t4 = "#bdae93";
                t5 = "#d5c4a1";
                t6 = "#ebdbb2";
                t7 = "#fbf1c7";

                black  = "#1d2021";
                red    = "#fb4934";
                orange = "#fe8019";
                yellow = "#fabd2f";
                green  = "#b8bb26";
                aqua   = "#8ec07c";
                blue   = "#83a598";
                purple = "#d3869b";
                brown  = "#d65d0e";
            };
            type = lib.types.submodule {
                options = lib.mapAttrs (_: default: lib.mkOption {
                    type = lib.types.str;
                    inherit default;
                }) {
                    bg = "#11111b";
                    mg = "#5b6078";
                    fg = "#cdd6f4";

                    t0 = "#11111b";
                    t1 = "#1e1e2e";
                    t2 = "#313244";
                    t3 = "#45475a";
                    t4 = "#5b6078";
                    t5 = "#7f849c";
                    t6 = "#a6adc8";
                    t7 = "#cdd6f4";

                    black = "#0f0f19";
                    red = "#f38ba8";
                    orange = "#fab387";
                    yellow = "#f9e2af";
                    green = "#a6e3a1";
                    aqua = "#94e2d5";
                    blue = "#89b4fa";
                    purple = "#cba6f7";
                    brown = "#f5c2e7";
                };
            };
            default = {};
        };
    };
}
