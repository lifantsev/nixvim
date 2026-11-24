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
            [[         \~-.  - /| __                       ]];
            [[        ,--. /~~~- '_ '                      ]];
            [[          ---, -- '__\                       ]];
            [[             |_/ -'                          ]];
            [[               |                             ]];
            [[               |                             ]];
            [[                |                            ]];
            [[          .--.--| _                          ]];
            [[      /_~--..-~~|  .--.    __  __ _          ]];
            [[      ~ .--  ,  l ' ---,   \ _ \  _'--,_     ]];
            [[       <,< /~ | \  ~-.      /__  / ~Z   ,_   ]];
            [[          ~   L_'|  _  _  _   `--   ,'   _7  ]];
            [[              |  __` ~\ | /  __  |\_/~-. |   ]];
            [[              | / __'- ,o--,'  '__      \|   ]];
            [[              | ~/_,--      >-~~ .>          ]];
            [[              |  ~   /_/|_/ -.~\             ]];
            [[              |   |  ~          |            ]];
            [[             |    |     |       |            ]];
            [[             |    |     |      |             ]];
            [[             |     |     |     |             ]];
            [[             |     |     |    |              ]];
            [[                                             ]];
            [[                                             ]];
            [[           │ ╲ ││ ╲╲  ╱╱ ││ │╲╲  ╱╱│         ]];
            [[           ││╲╲││  ╲╲╱╱  ││ ││╲╲╱╱││         ]];
            [[           ││ ╲ │   ╲╱   ││ ││ ╲╱ ││         ]];
        };
    })

    vim.opt.shortmess:append("I") -- disable default splash

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            if vim.fn.argc() == 0 then
                require('fsplash').open_window()
            end
        end,
    })
    '';
}
