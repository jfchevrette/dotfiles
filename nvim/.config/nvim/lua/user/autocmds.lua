local group = vim.api.nvim_create_augroup("autocd", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local ret, dir
    require'plenary.job':new({
      command = 'git',
      args = { 'rev-parse', '--show-toplevel' },
      cwd = vim.fn.getcwd(),
      on_exit = function(j, r)
        ret = r == 0 and r or nil 
        dir = ret and table.concat(j:result()) or nil
      end,
    }):sync()
  end,
  group = group
})

