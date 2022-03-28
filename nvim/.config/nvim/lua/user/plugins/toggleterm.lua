local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
	return
end

toggleterm.setup {
  open_mapping = [[<leader>t]],
  direction = 'float',
  float_opts = {
    border = 'curved',
  }
}
