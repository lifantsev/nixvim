{ lib, cfg, ... }: let modes = [ "n" "v" ]; dir = cfg.keys.directional; up = lib.toUpper; in { keymaps = [
    # window nav
    { mode = modes; key = "<leader>${dir.left}";  action = "<C-w><Left>"; }
    { mode = modes; key = "<leader>${dir.up}";    action = "<C-w><Up>"; }
    { mode = modes; key = "<leader>${dir.down}";  action = "<C-w><Down>"; }
    { mode = modes; key = "<leader>${dir.right}"; action = "<C-w><Right>"; }

    # opening splits
    { mode = modes; key = "<leader>${up dir.left}";  action = "<CMD>set nosplitright<CR>:vsplit<CR>"; }
    { mode = modes; key = "<leader>${up dir.up}";    action = "<CMD>set nosplitbelow<CR>:split<CR>"; }
    { mode = modes; key = "<leader>${up dir.down}";  action = "<CMD>set splitbelow<CR>:split<CR>"; }
    { mode = modes; key = "<leader>${up dir.right}"; action = "<CMD>set splitright<CR>:vsplit<CR>"; }

    # tab nav
    { mode = "n"; key = ";t"; action = "<CMD>tab split<CR>"; }
    { mode = modes; key = "<leader>ts"; action = "<CMD>tab split<CR>"; }
    { mode = modes; key = "<leader>t${dir.left}";  action = "<CMD>tabprev<CR>"; }
    { mode = modes; key = "<leader>t${dir.up}";    action = "<CMD>tabmove +<CR>"; }
    { mode = modes; key = "<leader>t${dir.down}";  action = "<CMD>tabmove -<CR>"; }
    { mode = modes; key = "<leader>t${dir.right}"; action = "<CMD>tabnext<CR>"; }
    
    # buffers
    { mode = "n"; key = ";h"; action = "<CMD>bdel<CR>"; }
    { mode = "n"; key = "<leader>h${dir.left}";  action = "<CMD>bprev<CR>"; }
    { mode = "n"; key = "<leader>h${dir.up}";    action = "<CMD>blast<CR>"; }
    { mode = "n"; key = "<leader>h${dir.down}";  action = "<CMD>bfirst<CR>"; }
    { mode = "n"; key = "<leader>h${dir.right}"; action = "<CMD>bnext<CR>"; }
    { mode = "n"; key = "<BS>"; action = "<C-^>"; } # previous buffer
    { mode = "n"; key = "<Left>"; action = "<C-o>"; } # jump positions within buffer
    { mode = "n"; key = "<Right>"; action = "<C-i>"; }
];}
