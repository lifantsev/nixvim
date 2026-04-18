{ cfg, ... }: {
    plugin.enable = true;
    plugin.settings = {
        custom_surroundings = let
            mkSurrounding = s: let
                l = builtins.substring 0 1 s;
                r = builtins.substring 1 1 s;
            in {
                input = [ "%${l}().-()%${r}" ];
                output = { left = l; right = r; };
            };
        in {
            b = mkSurrounding "()";
            B = mkSurrounding "{}";
            s = mkSurrounding "[]";
            a = mkSurrounding "<>";
            d = mkSurrounding "\"\"";
            q = mkSurrounding "''";
        };
        mappings = {
            add = "sa";
            delete = if cfg.keys.swap-rd then "sr" else "sd";
            replace = if cfg.keys.swap-rd then "sd" else "sr";
            find = "sf";
            find_left = "sF";
            highlight = "sh"; # useless, literally just flashes the chars
            update_n_lines = "sn"; # useless, sorta just changes n_lines

            suffix_last = "n";
            suffix_next = "o";
        };
    };
}
