{ ... }: {
    keymaps = [
        # undo redo
        { mode = "n"; key = "U"; action = "<CMD>silent redo<cr>"; }
        { mode = "n"; key = "u"; action = "<CMD>silent undo<cr>"; }

        # wrap toggle
        { mode = "n"; key = "<c-w>"; action = "<CMD>set wrap!<cr>"; }

        # conceal toggle
        { mode = "n"; key = "<c-c>"; action.__raw = ''function()
            if vim.wo.concealcursor ~= ""
            then vim.wo.concealcursor = ""
            else vim.wo.concealcursor = (vim.go.concealcursor ~= ""
                                        and vim.go.concealcursor or "n")
            end
        end''; }

        # quick sed binds
        { mode = "v"; key = "<leader>s"; action = "\"hy:%s/<c-r>h//g<left><left> <BS>"; }
        { mode = "n"; key = "<c-s>"; action = ":%s/"; }
        { mode = "v"; key = "<c-s>"; action = ":s/"; }

        # indent
        { mode = "n"; key = "<c-t>"; action = ">>"; }
        { mode = "n"; key = "<c-d>"; action = "<<"; }
        { mode = "v"; key = "<c-t>"; action = ">gv"; }
        { mode = "v"; key = "<c-d>"; action = "<gv"; }

        # incr/decr number
        { mode = "n"; key = "+"; action = "<c-a>"; }
        { mode = "n"; key = "-"; action = "<c-x>"; }

        # insert semicolon to the right
        { mode = "i"; key = "<c-;>"; action = ";<left>"; }
    ];
}
