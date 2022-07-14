" ***************************
" 	START COC SETTINGS
" ***************************
	
let g:use_coc=0
if use_coc

	set hidden 				" TextEdit might fail if hidden is not set
	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup
	set updatetime=300
	set shortmess+=c

	let g:coc_disable_startup_warning = 1

	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	"inoremap <Tab> <C-R>=CleverTab()<CR>
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ csdcCheckBackspace() ? "\<TAB>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
	function! CleverTab()
		if strpart( getline('.'), col('.')-2, 1) =~ '[a-zA-Z0-9_]'
			return "\<C-N>"
		else
			return "\<Tab>"
		endif
	endfunction


	let b:coc_suggest_disable = 1

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
	"
	"
	"
	" Use <c-space> to trigger completion.
	if has('nvim')
		inoremap <silent><expr> <c-space> coc#refresh()
	else
		inoremap <silent><expr> <c-@> coc#refresh()
	endif
	" Make <CR> auto-select the first completion item and notify coc.nvim to
	" format on enter, <cr> could be remapped by other vim plugin
	"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	"nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
	"nmap <silent> <leader>j <Plug>(coc-diagnostic-next)

	nnoremap <space>e :CocCommand explorer<CR>
	"
	" Formatting selected code.
	" xmap <leader>f  <Plug>(coc-format-selected)
	" nmap <leader>f  <Plug>(coc-format-selected)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	"
	"" Use K to show documentation in preview window.
	nnoremap <silent> <c-q> :call <SID>show_documentation()<CR>
	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		else
			execute '!' . &keywordprg . " " . expand('<cword>')
		endif
	endfunction

	"" Symbol renaming.
	nmap <leader>r <Plug>(coc-rename)
	" Mappings for CoCList
	" Show commands.
	nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>
	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)
endif

