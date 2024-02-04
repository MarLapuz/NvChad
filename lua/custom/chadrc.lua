---@type ChadrcConfig
local M = {}

M.ui = { theme = 'dark_horizon',
  Comment = {
    italic = true,
  },
  hl_override = {
    CursorLine = { bg = "#2a2e36" },
  },
  telescope = { style ="borderless"}, 
  statusline = {
  theme = "vscode_colored",
  separator_style = "default",
    overriden_modules =nil
}, tabufline = {
    show_numbers = false,
    enabled = false,
    lazyload = true,
    overriden_modules =nil
  } }

M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"

-- Add cursor line on active window
vim.cmd [[
 augroup CursorLine
   autocmd!
   autocmd WinEnter * setlocal cursorline
   autocmd WinLeave * setlocal nocursorline
 augroup END
]]

return M
