local ok, lualine = pcall(require, "lualine")
if not ok then
	return
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_lsp" },
  sections = { "error", "warn" },
  colored = false,
  update_in_insert = false,
  always_visible = true,
  icons_enabled = false,
}

local diff = {
  "diff",
  colored = false,
}

local mode = {
  "mode",
  fmt = function(str)
    str.format("-- %s --", str)
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
	"branch",
	icons_enabled = false,
	icon = nil,
}

local location = {
	"location",
	padding = 0,
}

-- local spaces = function()
-- 	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
-- end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { mode },
		lualine_c = {},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, filetype },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
