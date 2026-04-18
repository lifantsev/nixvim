{ lib, cfg, ... }: with cfg.keys; let dir = directional; up = lib.toUpper; in {
    plugin = {
        enable = true;

        settings = {
            mappings = {
                close       = ",";
                go_in_plus  = dir.right;
                go_out      = dir.left;
                reveal_cwd  = up dir.left;
                reset       = "<BS>";
                synchronize = "w";
                trim_left   = "<";
                trim_right  = ">";
                go_in       = "_";
                go_out_plus = "_";
                show_help   = "_";
            };

            windows = {
                preview = true;
                width_focus = 30;
                width_nofocus = 20;
                width_preview = 35;
            };
        };
    };

    keymaps = [{
        mode = "n";
        key = ",";
        action.__raw = "function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end";
        # opens and focuses current file, taken from :h MiniFiles.open()
    }];
}
