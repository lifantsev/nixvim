{ ... }: {
    plugin.enable = true;
    plugin.settings.use_default_keymaps = false;

    keymaps = [
        { mode = "n"; key = "<leader>e"; action = "<CMD>TSJToggle<CR>"; }
    ];
}
