local options = {
  -- enable syntax highlighting
  highlight = {
    enable = true,
    disabled = {},
  },
  -- enable indentation
  indent = { enable = true, disabled = {} },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "svelte",
    "prisma",
    "graphql",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
  },
  -- auto install above language parsers
  auto_install = true,
  -- incremental selection in visual mode
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false,
  -- },
  markdown = {
    enable = true,
  },
}

return options
