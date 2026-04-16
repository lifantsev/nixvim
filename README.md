# Nixvim flake
My personal neovim configuration, built using [nixvim](https://github.com/nix-community/nixvim).

## Usage
To quickly test drive my config, run:
```
nix run github:lifantsev/nixvim
```

To use my config in your nix configuration, add an input to your flake:
```
inputs.lifantsev-nixvim.url = "github:lifantsev/nixvim";
```

To install as a drop in replacement for the neovim package use:
```
# Make sure you've added lifantsev-nixvim as a flake input

# for NixOS
environment.systemPackages = [ inputs.lifantsev-nixvim.packages.${system}.default ];

# for Home-Manager
home.packages = [ inputs.lifantsev-nixvim.packages.${system}.default ];
```

This flake also provides a home manager module. Using the module allows you to tweak aspects of the config. Currently the only options availabe are `colorscheme` and `colors`, but I plan to add more in the future. For example, to use gruvbox instead of the default catppuccin mocha:
```
# Make sure you've added lifantsev-nixvim as a flake input

imports = [ inputs.lifantsev-nixvim.homeManagerModules.default ];

programs.lifantsev-nixvim = {
    enable = true;
    colorscheme = "gruvbox";
    colors = {
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
};
```

TODO using the flake if youre configuration isnt flake based (ie cant add a flake input)

### Binary Cache
This repository has a github workflow that automatically builds a package for `x86_64-linux` and `aarch64-linux` and pushes them to [cachix](https://lifantsev-nixvim.cachix.org). To tell nix to use this cache (you might want to if you have limited space or compute), add this to your configuration:
```
nix.settings = {
    extra-substituters = [ "https://lifantsev-nixvim.cachix.org" ];
    extra-trusted-public-keys = [ "lifantsev-nixvim.cachix.org-1:YrToDOQcRnfUaXmkCBgF4nN4Znsvq/tCCX1pISSmFm0=" ];
};
```
