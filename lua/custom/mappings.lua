local M = {}

-- Your custom mappings
M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "move left" },
    ["<C-l>"] = { "<Right>", "move right" },
    ["<C-j>"] = { "<Down>", "move down" },
    ["<C-k>"] = { "<Up>", "move up" },
  },

  n = {
    -- delete single character without copying into register
    ["x"] = { '"_x' },

    ["<Esc>"] = { ":noh <CR>", "clear highlights" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },

    -- save
    ["s"] = { "<cmd> wa <CR>", "save all file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

    -- line numbers
    -- ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    -- ["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    -- increment/decrement numbers
    ["+"] = { "<C-a>" }, -- increment
    ["-"] = { "<C-x>" }, -- decrement

    -- delete a word backwards
    ["dw"] = { 'vb"_d' },

    -- select all
    ["<C-a>"] = { "gg<S-v>G" },

    -- improved `J` so that the cursor will stay
    ["J"] = { "mzJ`z" },

    -- automatically center on ctrl + u or ctrl + down
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },

    -- keep search-term in the middle
    ["n"] = { "nzz" },
    ["N"] = { "Nzz" },

    -- Move to start/end of line
    ["H"] = { "^" },
    ["L"] = { "$" },

    -- go to ending bracket of function
    ["E"] = { "$%" },

    -- replace all text within the file that's under the cursor
    ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] },

    -- toggle transparency
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "toggle transparency",
    },

    -- map enter to ciw in normal moade
    ["<CR>"] = { "ciw" },

    ["<leader>rf"] = { ":TypescriptRenameFile<CR>", "rename file and update imports" },

    ["<leader>oi"] = { ":TypescriptOrganizeImports<CR>", "organize imports" },

    ["<leader>ru"] = { ":TypescriptRemoveUnused<CR>", "remove unused variables" },

    ["<leader>sv"] = { "<C-w>v", "split window vertically" },

    ["<leader>sh"] = { "<C-w>s", "split window hozontally" },

    ["<leader>se"] = { "<C-w>-=", "split window equally" },

    ["<leader>sx"] = { ":close<CR>", "close current split window" },

    ["<leader>to"] = { ":tabnew<CR>", "open new tab" },

    ["<leader>tx"] = { ":bd<CR>", "close current tab" },

    ["<leader>tn"] = { ":tabn<CR>", "go to next tab" },

    ["<leader>tp"] = { ":tabp<CR>", "go to previous tab" },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },

    -- move command on highlighted lines of code
    ["J"] = { ":m '>+1<CR>gv=gv" }, -- upward
    ["K"] = { ":m '<-2<CR>gv=gv" }, -- downward

    -- stay in visual mode when changing the indent for the selection
    ["<"] = { "<gv" },
    [">"] = { ">gv" },

    -- Move to start/end of line
    ["H"] = { "^" },
    ["L"] = { "$" },

    -- Search within visual block
    ["/"] = { "<Esc>/\\%V" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move left", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move down", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "dont copy replaced text", opts = { silent = true } },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gf"] = { "<cmd>Lspsaga finder<CR>", "show definition, references" },

    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>rn"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}


M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    -- ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fc"] = { "<cmd> Telescope grep_string <CR>", "Find string under cursor" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<leader>fp"] = { "<cmd> Telescope neovim-project discover <CR>", "Find projectsin current buffer" },
    ["<leader>fs"] = {
      function()
        require("telescope.builtin").grep_string { search = vim.fn.input "Grep > " }
      end,
      "Find string in current working directory",
    },
    ["<leader>fd"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "Find diagnostics",
    },

    -- git
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gcb"] = { "<cmd> Telescope git_bcommits <CR>", "Git commits current buffer" },
    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

    -- new
    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
  },
}


return M
