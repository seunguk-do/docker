-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")

local chatgpt = require("chatgpt")
wk.register({
  p = {
    name = "ChatGPT",
    e = {
      function()
        chatgpt.edit_with_instructions()
      end,
      "Edit with instructions",
    },
  },
}, {
  prefix = "<leader>",
  mode = "v",
})
