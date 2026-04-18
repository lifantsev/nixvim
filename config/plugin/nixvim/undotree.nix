{ ... }: {
    plugin.enable = true;

    keymaps = [{
        mode = "n";
        key = "<leader>u";
        action = "<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>";
    }];
}
