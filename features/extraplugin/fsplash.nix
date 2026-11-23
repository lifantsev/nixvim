{ ... }: {
    extraPlugin = {
        owner = "jovanlanik";
        repo = "fsplash.nvim";
        rev = "efd4565bbeb526a93c9cb25c24bd8123e1af63ee";
        hash = "sha256-OzBra/eBRfpx19+WRBBsm5PspZHrfFL7g+C8bxP3+Nc=";
    };

    lua.post = /*lua*/ ''
    require('fsplash').setup({
        lines = {
            [[ _  ___   _____ __  __ ]];
            [[| \| \ \ / /_ _|  \/  |]];
            [[| .` |\ V / | || |\/| |]];
            [[|_|\_| \_/ |___|_|  |_|]];
        };
    })
    '';
}
