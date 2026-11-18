# operator pending textobj remaps like c[iw]: change [in word]
{ lib, cfg, ... }: let
    modes = [ "o" "v" ];
    hjkl = cfg.keys.hjkl;
    i = lib.findFirst (name: hjkl.${name} == "i") "i" (builtins.attrNames hjkl);
    a = lib.findFirst (name: hjkl.${name} == "a") "a" (builtins.attrNames hjkl);
in {
    keymaps = [
        { mode = modes; key = "${i}q"; action = "i'"; }
        { mode = modes; key = "${a}q"; action = "a'"; }

        { mode = modes; key = "${i}d"; action = "i\""; }
        { mode = modes; key = "${a}d"; action = "a\""; }

        { mode = modes; key = "${i}a"; action = "i<"; }
        { mode = modes; key = "${a}a"; action = "a<"; }

        { mode = modes; key = "${i}s"; action = "i["; }
        { mode = modes; key = "${a}s"; action = "a["; }
    ];

    # lsp enabled node textobjects
    lua.post = /* lua */ ''
        local map = vim.fn.maparg("an", "x", false, true)
        if map and map.callback then
            vim.keymap.set({ "x", "o" }, "${a}n", map.callback, { desc = map.desc })
            vim.keymap.del({ "x", "o" }, "an")
        end

        local map = vim.fn.maparg("in", "x", false, true)
        if map and map.callback then
            vim.keymap.set({ "x", "o" }, "${i}n", map.callback, { desc = map.desc })
            vim.keymap.del({ "x", "o" }, "in")
        end
    '';
}
