{ lib, ... }: lib.mkOption {
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
    type = lib.types.submodule { options =
        lib.mapAttrs (_: default: lib.mkOption {
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
}
