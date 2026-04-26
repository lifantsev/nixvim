{ cfg, ... }: with cfg.keys.directional; {
    lua = /*lua*/ "require('winshift').setup()";

    keymaps = [
        { mode = "n"; key = "<leader>w${left}";  action = "<CMD>WinShift left<CR>"; }
        { mode = "n"; key = "<leader>w${up}";    action = "<CMD>WinShift up<CR>"; }
        { mode = "n"; key = "<leader>w${down}";  action = "<CMD>WinShift down<CR>"; }
        { mode = "n"; key = "<leader>w${right}"; action = "<CMD>WinShift right<CR>"; }
    ];
}
