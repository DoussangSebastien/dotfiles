return {
  'willothy/moveline.nvim',
  build = 'make',
  lazy = false,
  config = function()
    local moveline = require('moveline')
    vim.keymap.set('n', '<a-Up>', moveline.up)
    vim.keymap.set('n', '<a-Down>', moveline.down)
    vim.keymap.set('v', '<a-Up>', moveline.block_up)
    vim.keymap.set('v', '<a-Down>', moveline.block_down)
  end
}
