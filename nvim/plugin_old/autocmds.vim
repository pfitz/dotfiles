scriptencoding utf-8

if has('autocmd')
  function! s:PfitzAutoCommands()
    augroup PfitzAutoCommands
      autocmd!

      " shortly highlight the yanked text
      if exists('##TextYankPost')
        au TextYankPost * silent! lua require'vim.highlight'.on_yank()
      endif
    augroup END
  endfunction

  call s:PfitzAutoCommands()
endif
