"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'jremmen/vim-ripgrep'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'neovim/nvim-lspconfig'
Plug 'stevearc/conform.nvim'
Plug 'andymass/vim-matchup'
Plug 'machakann/vim-sandwich'
Plug 'catgoose/nvim-colorizer.lua'

Plug 'echasnovski/mini.nvim', {'branch': 'stable'}
Plug 'MeanderingProgrammer/render-markdown.nvim', {'for': 'markdown'}

Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

Plug 'jlanzarotta/bufexplorer'
nnoremap <silent> <leader><Space> :BufExplorer<cr>

Plug 'romgrk/barbar.nvim'
Plug 'preservim/tagbar'
Plug 'luukvbaal/statuscol.nvim'

Plug 'stevearc/oil.nvim'
nnoremap <silent> <leader>o :Oil<cr>
Plug 'nvim-tree/nvim-tree.lua'
nnoremap <silent> <C-N> :NvimTreeToggle<cr>

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
nnoremap <silent> <C-P> :Telescope find_files<cr>
nnoremap <silent> <C-F> :Telescope live_grep<cr>
nnoremap <silent> <leader>t :Telescope tags<cr>

Plug 'machakann/vim-swap'
Plug 'kqito/vim-easy-replace'
Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'

Plug 'github/copilot.vim'
Plug 'olimorris/codecompanion.nvim'
let g:copilot_assume_mapped = v:true
imap <silent><script><expr> <C-Cr> copilot#Accept("\<cr>")


call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_netrw = 1
let g:barbar_auto_setup = v:false
let g:markdown_fenced_languages = ['python', 'vim', 'sh', 'c', 'cpp', 'lua', 'rust', 'javascript', 'typescript']

lua << EOF
xpcall(function()
  require("oil").setup({
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
      ["?"] = { "actions.show_help", mode = "n" },
    },
  })
end, function(err)
end)

xpcall(function()
  require("conform").setup({
    formatters_by_ft = {
      python = { "black" },
      cpp = { "clang-format" },
      c = { "clang-format" },
    },
    format_on_save = {
        timeout_ms = 100,
        lsp_format = "fallback",
      },
  })
end, function(err)
end)

xpcall(function()
  require("nvim-tree").setup()
end, function(err)
end)

xpcall(function()
  require("render-markdown").setup()
end, function(err)
end)

xpcall(function()
  require("colorizer").setup()
end, function(err)
end)

xpcall(function()
  require("codecompanion").setup()
end, function(err)
end)

xpcall(function()
  require("statuscol").setup()
end, function(err)
end)

xpcall(function()
  require("telescope").setup{
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
        },
      },
    },
  }

  require("telescope").load_extension("ui-select")
end, function(err)
end)

xpcall(function()
  require'barbar'.setup {
    animation = false,
    clickable = false,
    icons = {
      buffer_index = false,
      buffer_number = false,
      button = '',
      modified = { button = '' },
      separator = { left = '', right = '' },
      separator_at_end = false,
      filetype = { enabled = false },
      alternate = { separator = { left = '', right = '' } },
      inactive = { separator = { left = '', right = '' } },
      visible = { separator = { left = '', right = '' } },
    },
    insert_at_end = true,
    maximum_padding = 1,
    maximum_length = 32,
    no_name_title = '*',
  }
end, function(err)
end)
EOF
