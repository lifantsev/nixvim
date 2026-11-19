{ ... }: {
    plugin = {
        enable = true;
        settings.use_default_keymaps = false;
        lazyLoad.settings.cmd = "TSJToggle";
    };

    keymaps = [
        { mode = "n"; key = "<leader>e"; action = "<CMD>TSJToggle<CR>"; }
    ];
}
