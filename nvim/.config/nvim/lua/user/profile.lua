local M = {}

function M.start()
  require("plenary.profile").start("/tmp/nvim_profile_flame.log", { flame = true })
end

return M
