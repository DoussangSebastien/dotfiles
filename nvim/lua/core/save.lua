local function save(opts)
  local buf = vim.api.nvim_get_current_buf()
  local has_name = vim.api.nvim_buf_get_name(buf) ~= ""

  if has_name then
    if opts.quit then
      vim.cmd("wqall") 
    else
      vim.cmd("write")
    end
  else
    vim.ui.input({ prompt = 'Save new file as: ' }, function(input)
      if input and input ~= "" then
        vim.cmd('write ' .. input)
        if opts.quit then
          vim.cmd("qa")
        end
      end
    end)
  end
end

vim.api.nvim_create_user_command('W', function() save({ quit = false }) end, {})
vim.api.nvim_create_user_command('Wq', function() save({ quit = true }) end, {})

vim.cmd([[
  cnoreabbrev <expr> w (getcmdtype() == ':' && getcmdline() == 'w') ? 'W' : 'w'
  cnoreabbrev <expr> wq (getcmdtype() == ':' && getcmdline() == 'wq') ? 'Wq' : 'wq'
]])
