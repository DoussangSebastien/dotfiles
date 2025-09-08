-- No need to copy this inside `setup()`. Will be used automatically.
return {
  -- Icon style: 'glyph' or 'ascii'
  "nvim-mini/mini.icons",
  style = 'glyph',

  default   = {},
  directory = {},
  extension = {},
  file      = {},
  filetype  = {},
  lsp       = {},
  os        = {},
  use_file_extension = function(ext, file) return true end,
}
