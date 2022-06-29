set shell=/bin/zsh
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=0
set autoindent
set hlsearch
set clipboard=unnamed
syntax on

nnoremap x "_x
nnoremap s "_s

" vim commentaryのinstall
" mkdir -p ~/.config/nvim/pack/tpope/start
" cd ~/.config/nvim/pack/tpope/start
" git clone https://tpope.io/vim/commentary.git
" vim -u NONE -c "helptags commentary/doc" -c q

" call plug#begin()
" Plug ‘ntk148v/vim-horizon’
" Plug ‘preservim/nerdtree’
" Plug ‘rafi/awesome-vim-colorschemes’
" call plug#end()

" nnoremap <C-n> :NERDTree<CR>
" ” Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists(‘s:std_in’) | NERDTree | endif

" colorscheme onedark

" if exists(‘g:vscode’)
"     ” VSCode extension
" else
"     ” ordinary neovim
" endif
