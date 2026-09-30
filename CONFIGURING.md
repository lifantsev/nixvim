# Configuring
All options are under `programs.lifantsev-nixvim`.

## enable
Whether to enable the module, which will configure neovim through [nixvim](https://github.com/nix-community/nixvim).
```nix
enable = false;
```

## wipe
Whether to wipe all defaults (set them to empty attrsets). Enable this if you want to start your own config from stratch.
```nix
wipe = false;
```

## colorscheme
Name of the nixvim colorscheme to enable.
``` nix
colorscheme = "catppuccin";
```

## colorschemeSettings
Attrset of settings to pass to the nixvim colorscheme.
- default:
``` nix
colorschemeSettings = {
    transparent_background = true;
    float.transparent = true;
}
```

## features
The meat & potatoes of this flake. An attrset of atomic features, each of which is able to set keymaps, install `vimPlugins`, install `nixvimPlugins`, and add `init.lua`.
``` nix
features = import ../features args;
```
This flake contains a [features](features/) directory which is compiled into a suitable attrset using [features/default.nix](features/default.nix). If you would like to configure your own feature set similarly, just copy the file. You can also just edit the attrset itself by adding features like this:
```nix
features.indent-blankline = {
    enable = true;

    # keymaps to add to nixvim.keymaps
    keymaps = [ { mode = [ "n" "v" ]; key = "<leader>n"; action = "<C-w><Left>"; } ];

    # whether to install pkgs.vimPlugins.indent-blankline
    vimPlugin = false;

    # config attrset to pass to nixvim.plugins.indent-blankline
    nixvimPlugin = {
        enable = true;
        settings = {
            indent.char = "┊";
            indent.highlight = [ "IblChar" ];
        };
    };

    # prepend to init.lua
    lua.pre = /*lua*/ ''
        local ibl_hooks = require("ibl.hooks")
        ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IblChar", { fg = "${cfg.colors.t1}" })
        end)
    '';

    # append to init.lua
    lua.post = /*lua*/ ''print("hello world!")'';
};
```

## keys
Settings used by the default features; this option is noop if you disable those.

### keys.swap-rd
Swap r & d keys. I personally like this but it shouldn't be default behaviour; thus this option.
```nix
keys.swap-rd = false;
```

### keys.leader
The leader key: `vim.g.mapleader` / `nixvim.globals.mapleader`.
```nix
keys.leader = " ";
```

### keys.directional
Keys to bind to directional motions (useful for non-qwerty users).
```nix
keys.directional = {
    left  = "h";
    down  = "j";
    up    = "k";
    right = "l";
};
```

### keys.hjkl
If you set `keys.directional`, `hjkl` would now be unbound. By default they are swapped one to one, but you can use this option to specify something else.
```nix
keys.hjkl = {
    h = keys.directional.left; # say you set keys.directional.left to [i]
    j = keys.directional.down; # now the [h] key will be bound to the former action of [i]
    k = keys.directional.up;   # that is, it will enter insert mode
    l = keys.directional.right;
};
```

## colors
Hex colors used by the default features to set up custom highlights. If you are not using the default features, this option is noop.
```nix
colors = {
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
```
