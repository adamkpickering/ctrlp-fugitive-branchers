" =============================================================================
" File:          autoload/ctrlp/fugitivebranches.vim
" Description:   Git branch finder using fugitive.vim
" Author:        Adam Pickering
" =============================================================================

" To load this extension into ctrlp, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['fugitivebranches']
"
" Where 'fugitivebranches' is the name of the file 'sample.vim'
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'my_extension',
"         \ 'my_other_extension',
"         \ ]

" Load guard
if ( exists('g:loaded_ctrlp_fugitivebranches') && g:loaded_ctrlp_sample )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_fugitivebranches = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
	\ 'init': 'ctrlp#fugitivebranches#init()',
	\ 'accept': 'ctrlp#fugitivebranches#accept',
	\ 'lname': 'git branches',
	\ 'sname': 'branches',
	\ 'type': 'path',
	\ })


" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#fugitivebranches#init()
	let input = systemlist("git branch -a")
  return input
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#fugitivebranches#accept(mode, str)
  call execute(":Git checkout " + a:str)
  call ctrlp#exit()
endfunction


" (optional) Do something before enterting ctrlp
"function! ctrlp#fugitivebranches#enter()
"endfunction


" (optional) Do something after exiting ctrlp
"function! ctrlp#fugitivebranches#exit()
"endfunction


" (optional) Set or check for user options specific to this extension
"function! ctrlp#fugitivebranches#opts()
"endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#fugitivebranches#id()
	return s:id
endfunction


" Create a command to directly call the new search type
"
" Put this in vimrc or plugin/fugitivebranches.vim
" command! CtrlPSample call ctrlp#init(ctrlp#fugitivebranches#id())


" vim:nofen:fdl=0:ts=2:sw=2:sts=2
