
local M = {}

M.general = {
  -- ":W" -> sudo saves current file
  ["-nargs=0 W"] = "execute 'w !sudo tee % > /dev/null'",

  -- ":FoldAll"
  ["-nargs=0 FoldAll"] = "normal! zM<CR>",

  -- ":UnFoldAll"
  ["-nargs=0 UnFoldAll"] = "normal! zR<CR>",
}

return M