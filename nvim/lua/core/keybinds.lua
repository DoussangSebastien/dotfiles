local keymap = vim.keymap
local bufopts = { noremap = true, silent = true, buffer = bufnr }

-- basic keybinds

keymap.set("n", "k", "kzz", { desc = "Arrow up and center" })
keymap.set("n", "j", "jzz", { desc = "Arrow down and center" })
keymap.set("n", "<Up>", "kzz", { desc = "Arrow up and center" })
keymap.set("n", "<Down>", "jzz", { desc = "Arrow down and center" })

-- nvim-tree

keymap.set("n", "<leader>e", ":Neotree<CR>")
vim.keymap.set("n", "<leader>z", ":Neotree close<CR>", { noremap = true, silent = true })

-- telescope

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fn", "<cmd>Telescope help_tags<cr>")

-- lsp
keymap.set("n", "<leader>l", vim.diagnostic.open_float, bufopts)

-- transparency
keymap.set("n", "<leader>cc", "<cmd>TransparentToggle<cr>")
