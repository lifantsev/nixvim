{ config, ... }: {
    plugin = {
        enable = true;
        grammarPackages = let 
            plugins = config.programs.nixvim.plugins or config.plugins;
        in with plugins.treesitter.package.builtGrammars;
        [
            json toml yaml xml
            vim vimdoc
            markdown
            tree-sitter-css
            make
            regex 

            bash zsh
            lua python
            javascript prisma
            cpp
            nix
        ];

        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
    };
}
