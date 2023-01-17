# ctrlp-kensaku

CtrlP matcher using [lambdaisue/kensaku.vim](https://github.com/lambdalisue/kensaku.vim).

## Setup
```
let g:ctrlp_match_func = {'match': 'ctrlp_kensaku#matcher'}
```

## Installation

For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```
Plug 'vim-denops/denops.vim'
Plug 'lambdalisue/kensaku.vim' 
Plug 'ompugao/ctrlp-kensaku'
```

## Usage

If you want to find a file named in Japanese, add the following lines to your vimrc for example.
```
function! s:kensaku() abort
  let l:oldmatcher = g:ctrlp_match_func
  let g:ctrlp_match_func = {'match': 'ctrlp_kensaku#matcher'}
  execute("CtrlP")
  let g:ctrlp_match_func = l:oldmatcher
endfunction
command! CtrlPKensakuFiles call <SID>kensaku()
```

## License

MIT

