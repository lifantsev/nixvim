{ lib, cfg, ... }:
with cfg.keys;
with cfg.keys.directional;
with lib;
let
    modes = [ "n" "v" "s" "x" "o" ];
    modes_n = lib.lists.remove "n" modes;
in {
    keymaps = [
        # lowercase directional
        { mode = modes;   key = left;  action = "h"; }
        { mode = modes_n; key = up;    action = "k"; }
        { mode = modes_n; key = down;  action = "j"; }
        { mode = modes;   key = right; action = "l"; }

        { mode = "n"; key = up;   action = "gk"; }
        { mode = "n"; key = down; action = "gj"; }

        # uppercase directional
        { mode = "n";     key = toUpper left; action = "mzJ`z"; }
        { mode = modes_n; key = toUpper left; action = "H"; }

        { mode = "v"; key = toUpper up; action = ":m '<-2<cr>gv=gv"; } # moves line up in visual mode
        { mode = "n"; key = toUpper up; action = "<C-u>"; } # goes up a page, keeping cursor centered
        { mode = "o"; key = toUpper up; action = "K"; }

        { mode = "v"; key = toUpper down; action = ":m '>+1<cr>gv=gv"; }
        { mode = "n"; key = toUpper down; action = "<c-d>"; }
        { mode = "o"; key = toUpper down; action = "J"; }

        { mode = modes; key = toUpper right; action = "L"; }

        # HJKL lower & upper
        { mode = modes; key = "h"; action = hjkl.h; }
        { mode = modes; key = "k"; action = hjkl.k; }
        { mode = modes; key = "j"; action = hjkl.j; }
        { mode = modes; key = "l"; action = hjkl.l; }

        { mode = modes; key = "H"; action = toUpper hjkl.h; }
        { mode = modes; key = "K"; action = toUpper hjkl.k; }
        { mode = modes; key = "J"; action = toUpper hjkl.j; }
        { mode = modes; key = "L"; action = toUpper hjkl.l; }
    ];
}
