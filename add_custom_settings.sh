# custom configurations
echo 'Adding custom configurations'
touch $HOME/.vimrc.local

echo 'se nu
se nu rnu
nnoremap <space> zO
vnoremap <space> zc

nnoremap <leader>vs :%s/\%V
nnoremap <leader>s :%s/<c-r><c-w>/
nnoremap <leader>qq :qa!<CR>
nnoremap ee :
nnoremap <c-]> :bnext<CR>
nnoremap <c-[> :bprevious<CR>
nnoremap <leader>` i''<Esc>i
nnoremap ff :/
nnoremap <leader>qa :qa!<CR>

inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>]<Esc>O

silent! colorscheme evening' > $HOME/.vimrc.local

touch $HOME/.zsh/zsh.d/zsh_custom_settings.zsh
echo "# custom functions
function _git_status {
    echo
    git status
    zle reset-prompt
}

# zle handler
zle -N _git_status

# custom binding
bindkey '^E' fzf-cd-widget
bindkey '^F' forward-char
bindkey '^S' _git_status

alias tl='tmux ls'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'" > $HOME/.zsh/zsh.d/zsh_custom_settings.zsh