{ ... }: {
    plugin = {
        enable = true;

        settings = {
            new_note_location = "current_dir";
            picker.name = "telescope.nvim";

            legacy_commands = false;

            workspaces = [{
                name = "main";
                path = "~/obsidian";
            }];

            checkbox.order = [ " " "x" ];

            frontmatter.enabled = false; # metadata @ top of file
            footer.enabled = false; # link count & word count footer
            ui.enable = false; # use default markdown concealer
            daily_notes.enabled = false;
        };
    };

    keymaps = [
        { mode = "n"; key = "<leader>sb"; action = "<CMD>Obsidian backlinks<CR>"; }
    ];
}
