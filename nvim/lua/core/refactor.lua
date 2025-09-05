local M = {}

function M.refactor()
  local params = vim.lsp.util.make_position_params(nil, "utf-16")
  local res = vim.lsp.buf_request_sync(0, "textDocument/prepareRename", params, 500)
  if res then
    for _, r in pairs(res) do
      if r and r.result then
        vim.lsp.buf.rename()
        return
      end
    end
  end
  local word = vim.fn.expand("<cword>")
  local new = vim.fn.input("Rename '" .. word .. "' to: ")
  if new ~= "" then
    vim.cmd("%s/\\V" .. word .. "/" .. new .. "/gc")
  end
end

return M
