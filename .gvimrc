if !has("gui_running")
	finish
endif

" GUI settings
let g:my_gvim_dir = expand("~/Documents/gvim")

if !isdirectory(g:my_gvim_dir)
	call mkdir(g:my_gvim_dir, "p")
endif

function! OpenWithCorrectDirectory()
	if argc() == 0
		" Cambia el directorio de trabajo a g:my_gvim_dir si no se abrió ningún archivo
		execute 'cd' g:my_gvim_dir
	else
		" Si se abrió un archivo, cambia al directorio de ese archivo
		execute 'cd' fnameescape(expand('%:p:h'))
	endif
endfunction


" Llama a la función al iniciar GVim
autocmd VimEnter * call OpenWithCorrectDirectory()

" fix gx command for opening urls in browser
let g:netrw_browsex_viewer="setsid xdg-open"

set guioptions-=m " hide menu bar
set guioptions-=T " hide options bar
set guioptions= "hide all ui including scrollbars"
set guifont=MartianMono\ Nerd\ Font\ Mono\ 10

"toggle menu bar
nnoremap <silent> <A-m> :if exists("g:menu_visible") && g:menu_visible == 1<CR>:set guioptions-=m<CR>:let g:menu_visible=0<CR>:else<CR>:set guioptions+=m<CR>:let g:menu_visible=1<CR>:endif<CR>

" fix pasting (for insert/normal/terminal/command mode)
imap <C-S-v> <C-R><C-O>+
nnoremap <C-S-v> "+p
tmap <C-S-v> <C-W>"*
cnoremap <C-S-v> <C-R>+

" window resize
nnoremap <C-Right> :exe "set columns=" . (&columns + 5)<CR>
nnoremap <C-Left> :exe "set columns=" . (&columns - 6)<CR>
nnoremap <C-Down> :exe "set lines=" . (&lines + 2)<CR>
nnoremap <C-Up> :exe "set lines=" . (&lines - 2)<CR>
