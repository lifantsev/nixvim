# Nixvim Config Framework
Framework that defines the config as a set of atomic features, each one being able to install a plugin, set keymaps, and edit `init.lua`. Built using [nixvim](https://github.com/nix-community/nixvim). Defaults are set to my personal neovim config, but can easily be overwritten.

- [usage](#Usage), [configuration](#Configuration), [binary cache](#Binary-Cache)

## Usage
To quickly test drive my config, run:
``` sh
nix run github:lifantsev/nixvim
```

To use this flake in your nix configuration, add an input:
``` nix
# flake.nix
inputs.lifantsev-nixvim.url = "github:lifantsev/nixvim";
```

To install my config as a drop in replacement for the neovim package use:
``` nix
# Make sure you've added lifantsev-nixvim as a flake input

# for NixOS
environment.systemPackages = [ inputs.lifantsev-nixvim.packages.${system}.default ];

# for Home-Manager
home.packages = [ inputs.lifantsev-nixvim.packages.${system}.default ];
```

## Configuration
See [CONFIGURING.md](CONFIGURING.md) for a description of all options. This flake exposes a home manager module that allows you to tweak aspects of the config, or build your very own from scratch. For example, to use gruvbox instead of catppuccin and disable the lualine feature:
``` nix
# Make sure you've added lifantsev-nixvim as a flake input

imports = [ inputs.lifantsev-nixvim.homeManagerModules.default ];

programs.lifantsev-nixvim = {
    enable = true;
    colorscheme = "gruvbox";
    features.lualine.enable = false;
};
```

## Binary Cache
This repository has a github workflow that automatically builds a package for `x86_64-linux` and `aarch64-linux` and pushes them to [cachix](https://lifantsev-nixvim.cachix.org). To tell nix to use this cache (you might want to if you have limited space or compute), add this to your configuration:
``` nix
nix.settings = {
    extra-substituters = [ "https://lifantsev-nixvim.cachix.org" ];
    extra-trusted-public-keys = [ "lifantsev-nixvim.cachix.org-1:YrToDOQcRnfUaXmkCBgF4nN4Znsvq/tCCX1pISSmFm0=" ];
};
```
