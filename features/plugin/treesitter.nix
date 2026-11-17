{ config, ... }: {
    plugin = {
        enable = true;
        grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
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

        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
    };
}
