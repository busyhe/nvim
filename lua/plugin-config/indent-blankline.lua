local status, ident_blankline = pcall(require, "ibl")
if not status then
  vim.notify("没有找到 indent_blankline")
  return
end

ident_blankline.setup({
  -- space_char_blankline = " ",
  scope = {
    show_start = true,
  },
  exclude = {
    filetypes = {
      "checkhealth",
      "man",
      "gitcommit",
      "null-ls-info",
      "dashboard",
      "packer",
      "terminal",
      "help",
      "log",
      "markdown",
      "TelescopePrompt",
      "TelescopeResults",
      "lsp-installer",
      "lspinfo",
      "toggleterm",
      "text",
      "''",
    },
  },
  indent = {
    -- char = '¦'
    -- char = '┆'
    -- char = '│'
    -- char = "⎸",
    char = "▏",
  },
})
