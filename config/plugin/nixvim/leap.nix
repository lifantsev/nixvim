{ ... }: {
    plugin.enable = true;

    keymaps = let modes = [ "n" "x" "o" ]; in [
        { mode = modes; key = "<tab>"; action = "<Plug>(leap)"; }
        { mode = modes; key = "<s-tab>"; action = "<Plug>(leap-anywhere)"; }
    ];
}
