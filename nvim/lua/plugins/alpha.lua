return {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local status_ok, alpha = pcall(require, "alpha")
        if not status_ok then
            return
        end

        local lazy_stats = require("lazy").stats()
        local plugins_count = lazy_stats.count

        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.val = {
            '                               ,                             ',
            '                               B                             ',
            '                              BMB.                           ',
            '                            3BBBMBX                          ',
            '                         .PMBMBMBMBBD,                       ',
            '                       7MBMBMBMBMBMBMBMs                     ',
            '                    :EBMBMBMBMx iMBMBMBMBO:                  ',
            '                  7BMBMBBBMBJ     vBBBBBMBMBs                ',
            '                xMBMBBBMBH,    .    .UBMBMBMBBF              ',
            '   .          .BMBBBMBX:      :Br      .FBMBMBBB:            ',
            '   LR;,.:rUOBMBMBMBM;       ;MBMBBr       :OBMBMBBBRSr:.,:EU ',
            '    MBMBMBBBMBMBMM.      :0BMBBEMBMBD:       WMBBBMBMBMBMBM  ',
            '    HMB.::.  BBMc     .HBMBMBK   FBBBMBZ,     ;BBB  .::.BBM  ',
            '    MBM      UMP    .BMBMBZ:       ,HBMBMB:    LBM      MBM  ',
            '    BBB   BMBMBr   cBMBW:     0BM     .0BMBF   .BMBMB   BMB: ',
            '   WBBx   cBL.iB   BMR     cMBM1MBM3     PMB   M7,;BK   ;BMB ',
            '   MBM    BM:  .J  BB    RBMB;   :RMBM    RM  c:   MB    MBM ',
            '  :BM7    BB     , ,M   MBr         ;BM   Or .     BM:   :MBi',
            '  :MB,   7B7        .i  B             B  ::        :BS    BM ',
            '   BMG    BK             :           .,            cM:   2MB ',
            '    BMH   .Mi     : :                 E:          :M:   sMB  ',
            '     ;MRui  ;:.   :Fui:;  :;;7i   .;;;rS:,  rr   ,:  :7EO:   ',
            '       ██████:::█████UUi:77;::37s7L███  ,;3SD,....:;;,       ',
            '       ░░██████ ░░███:  .      rs: ░░░ ..;LxxUWRFU;::7OW     ',
            '       ░███░███ ░███  █████ █████ ████  █████████████        ',
            '       ░███░░███░███ ░░███ ░░███ ░░███ ░░███░░███░░███       ',
            '       ░███ ░░██████  ░███  ░███  ░███  ░███ ░███ ░███       ',
            '       ░███  ░░█████  ░░███ ███   ░███  ░███ ░███ ░███       ',
            '       █████  ░░█████  ░░█████    █████ █████░███ █████      ',
            '       ░░░░░    ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░      ',

        }
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
            dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("c", "  Configuration", ":e ~/.config/nvim<CR>"),
            dashboard.button("l", "  Lazy", ":Lazy<CR>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        dashboard.section.footer.val = {
            "",
            "--   Neovim Loaded " .. plugins_count .. " plugins    --",
            "",
        }

        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.opts.opts.noautocmd = true
        dashboard.opts.layout[1].val = 0

        alpha.setup(dashboard.opts)
    end,
}
