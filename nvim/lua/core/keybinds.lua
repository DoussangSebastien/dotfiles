local keymap = vim.keymap
local bufopts = { noremap = true, silent = true, buffer = bufnr }

-- Press '²' for the full list of keybinds ! 
-- <leader> = ' ' and can be modified in /lua/core/options.lua

-- navigating files
keymap.set("n", "k", "kzz", { desc = "Arrow up and center" })
keymap.set("n", "j", "jzz", { desc = "Arrow down and center" })
keymap.set("n", "<Up>", "kzz", { desc = "Arrow up and center" })
keymap.set("n", "<Down>", "jzz", { desc = "Arrow down and center" })

-- indenting blocks
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Ctrl + Z and Ctrl + Shift + Z
vim.keymap.set("n", "<C-z>", "u", { noremap = true })
vim.keymap.set("n", "<C-S-z>", "<C-r>", { noremap = true })

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
keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<cr>")

-- treesitter
-- c to comment line/blocks
-- cc to uncomment line/blocks

-- moveline
local ok, moveline = pcall(require, "moveline")
if not ok then
  return
end
-- line (working only in lua/plugin/moveline.lua)
-- vim.keymap.set('n', '<a-Up>', moveline.up)
-- vim.keymap.set('n', '<a-Down>', moveline.down)
-- vim.keymap.set('v', '<a-Up>', moveline.block_up)
-- vim.keymap.set('v', '<a-Down>', moveline.block_down)
