{ lib, options, cfg, ... }@args: lib.mkOption {
    # to disable a feature, set it to {}
    description = "an attrset of features to add to nvim (can add keymaps, plugins, lua code)";
    defaultText = "my personal set of features";
    example = {
        indent-blankline = import ../config/plugin/indent-blankline.nix args;
    };
    type = lib.types.attrsOf (lib.types.submodule ({ name, ... }: { options = {
        enable = lib.mkEnableOption "the ${name} feature";

        keymaps = lib.mkOption {
            description = "keymaps to pass through to nixvim.keymaps";
            type = options.programs.nixvim.keymaps.type;
            default = [];
            example = [ { mode = [ "n" "v" ]; key = "<leader>n"; action = "<C-w><Left>"; } ];
        };

        vimPlugin = lib.mkOption {
            description = "whether to install pkgs.vimPlugins.${name}";
            type = lib.types.bool;
            default = false;
            example = true;
        };

        nixvimPlugin = lib.mkOption {
            description = "nixvim plugin configuration to pass to nixvim.plugins.${name} set to {} to disable";
            type = if (builtins.hasAttr name options.nixvim.plugins)
                   then options.nixvim.plugins.${name}.type
                   else lib.types.attrsOf lib.types.anything;
            default = {};
            example = {
                enable = true;
                foo = "bar";
            };
        };

        lua = lib.mkOption {
            description = "lua code to add to init.lua";
            type = lib.types.submodule { options = {
                pre = lib.mkOption {
                    description = "code to add to the beginning of init.lua";
                    type = lib.types.str;
                    default = "";
                    example = "vim.o.mouse = ''";
                };
                post = lib.mkOption {
                    description = "code to add to the end of init.lua";
                    type = lib.types.str;
                    default = "";
                    example = "vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '${cfg.colors.mg}' })";
                };
            };};
        };
    };}));
    default = {}; # TODO
}
