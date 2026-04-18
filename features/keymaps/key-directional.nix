{ lib, cfg, ... }: with cfg.keys; with lib; let modes = [ "n" "v" "s" "x" "o" ]; dir = directional; in { keymaps = [
    { mode = modes; key = dir.left; action = "h"; }
    { mode = lists.remove "n" modes; key = dir.up; action = "k"; } { mode = "n"; key = dir.up; action = "gk"; }
    { mode = lists.remove "n" modes; key = dir.down; action = "j"; } { mode = "n"; key = dir.down; action = "gj"; }
    { mode = modes; key = dir.right; action = "l"; }

    { mode = "n"; key = toUpper dir.left; action = "mzJ`z"; }
    { mode = lists.remove "n" modes; key = toUpper dir.left; action = "H"; }

    { mode = "v"; key = toUpper dir.up; action = ":m '<-2<cr>gv=gv"; } # moves line up in visual mode
    { mode = "n"; key = toUpper dir.up; action = "<C-u>"; } # goes up a page, keeping cursor centered
    { mode = "o"; key = toUpper dir.up; action = "K"; }

    { mode = "v"; key = toUpper dir.down; action = ":m '>+1<cr>gv=gv"; }
    { mode = "n"; key = toUpper dir.down; action = "<c-d>"; }
    { mode = "o"; key = toUpper dir.down; action = "J"; }

    { mode = modes; key = toUpper dir.right; action = "L"; }

    { mode = modes; key = "h"; action = hjkl.h; }
    { mode = modes; key = "k"; action = hjkl.k; }
    { mode = modes; key = "j"; action = hjkl.j; }
    { mode = modes; key = "l"; action = hjkl.l; }

    { mode = modes; key = "H"; action = toUpper hjkl.h; }
    { mode = modes; key = "K"; action = toUpper hjkl.k; }
    { mode = modes; key = "J"; action = toUpper hjkl.j; }
    { mode = modes; key = "L"; action = toUpper hjkl.l; }
];}
