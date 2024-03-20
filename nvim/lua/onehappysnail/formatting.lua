local staus_formatter_ok, formatter = pcall(require, "formatter")
if not staus_formatter_ok then
  return
end

local util = require "formatter.util"

formatter.setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    javascript = {
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--tab-width",
            4,
          },
          stdin = true,
        }
      end
    },
  },
}

