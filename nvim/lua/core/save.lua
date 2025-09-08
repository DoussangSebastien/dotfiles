vim.api.nvim_create_user_command('W', function()
  if vim.api.nvim_buf_get_name(0) ~= '' then
    vim.cmd.write()
  else
    vim.ui.input({ prompt = 'Filename: ' }, function(path)
      if path then vim.cmd('write ' .. path) end
    end)
  end
end, {})

vim.api.nvim_create_user_command('Wq', function()
  if vim.api.nvim_buf_get_name(0) ~= '' then
    vim.cmd.wq()
  else
    vim.ui.input({ prompt = 'Filename: ' }, function(path)
      if path then vim.cmd('write ' .. path .. ' | q') end
    end)
  end
end, {})

vim.cmd([[
cabbrev w W
cabbrev wq Wq
]])

