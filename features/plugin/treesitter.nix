{ pkgs, ... }: { plugin = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        json toml yaml xml
        vim vimdoc
        markdown
        make
        regex 

        bash zsh
        lua python
        javascript prisma
        cpp
        nix
    ];

    settings = {
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
    };
};}
