{ ... }: let modes = [ "n" "v" "s" "x" "o" ]; in { keymaps = [
    { mode = modes; key = "r"; action = "d"; }
    { mode = modes; key = "R"; action = "D"; }
    { mode = modes; key = "d"; action = "r"; }
    { mode = modes; key = "D"; action = "R"; }
];}
