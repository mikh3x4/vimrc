if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tomasr/molokai'

Plug 'bling/vim-airline'

" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" need to set leader 
"
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'


Plug 'jpalardy/vim-slime', { 'for': 'python' }
" Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Plug 'szymonmaszke/vimpyter' "vim-plug # notedown
Plug 'anosillus/vim-ipynb' "vim-plug # ipynb-py-convert
" Plug 'goerz/jupytext.vim' "vim-plug # jupytext



let g:slime_target = 'tmux'

" fix paste issues in ipython
let g:slime_python_ipython = 1

let g:slime_cell_delimiter = "# %%"
let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
let g:slime_dont_ask_default = 1

nmap g<CR> <Plug>SlimeSendCell

" Plug 'svermeulen/vim-easyclip'
Plug 'svermeulen/vim-cutlass'
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" allows mark to be accessed
nnoremap gm m

Plug 'svermeulen/vim-subversive'
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)


" Plug 'svermeulen/vim-yoink'

" nmap <c-[> <plug>(YoinkPostPasteSwapBack)
" nmap <c-]> <plug>(YoinkPostPasteSwapForward)
" nmap p <plug>(YoinkPaste_p)
" nmap P <plug>(YoinkPaste_P)

" nmap [y <plug>(YoinkRotateBack)
" nmap ]y <plug>(YoinkRotateForward)
" let g:yoinkIncludeDeleteOperations = 1

Plug 'mg979/vim-visual-multi'
" Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'

" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

call plug#end()

colo molokai
if has("gui_vimr")
	 let g:molokai_original = 1
endif

autocmd ColorScheme * hi MatchParen cterm=bold ctermbg=black ctermfg=208
" autocmd ColorScheme * hi MatchParen gui=bold guibg=none guifg=#FD971F

nnoremap <c-p> :GFiles<cr>

" ctrlp settings
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
"
"
" easymotoin settings
"
let g:EasyMotion_do_mapping = 0

nmap gw <Plug>(easymotion-overwin-f2)
" nmap s <Plug>(easymotion-overwin-w)
nmap <Space> <Plug>(easymotion-overwin-w)
let g:EasyMotion_keys = 'sadfjklewcmpgh'

let g:EasyMotion_smartcase = 1


inoremap jk <Esc>

set number
set relativenumber
set cursorline
syntax on

" incremental search
set incsearch
set hlsearch

"save shortcut
command W w

let g:EasyClipUseSubstituteDefaults = 1

" noremap <c-]> <plug>EasyClipSwapPasteForward
" noremap <c-[> <plug>EasyClipSwapPasteBackward

" let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabContextDefaultCompletionType = "<c-n>"

let g:VM_maps = {}
let g:VM_maps["Switch Mode"] = 'v'
let g:VM_maps['Find Under']                  = '<C-n>'
let g:VM_maps['Find Subword Under']          = '<C-n>'
let g:VM_maps["Add Cursor Down"]             = '<C-j>'
let g:VM_maps["Add Cursor Up"]               = '<C-k'

let g:VM_maps["Align"]                       = 'ga'
let g:VM_maps["Visual Cursors"]              = 'gl'


" Python config
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=120
    \set expandtab
    \set autoindent
"     \set fileformat=unix

" C config
au BufNewFile,BufRead *.cc,*.c,*cpp,*.h,*.hpp set tabstop=4|
    \set softtabstop=4|
    \set shiftwidth=4|
    \set textwidth=120|
    \set expandtab|
    \set autoindent
"     \set fileformat=unix



"caused issues 
"nnoremap <esc> :noh<return><esc>

" makes enter key highlight word under cursor
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()


" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


