#!/bin/bash
# check if curl installed
if ! command -v 'curl' $> /dev/null
then
	echo "curl package not installed, installing...\n"
	sudo apt-get install curl
else
	echo "curl package already installed"
fi

# check if git installed
if ! command -v 'git' $> /dev/null
then
	echo "git package not installed, installing...\n"
	sudo apt install git
else
	echo "git package already installed"
fi

# check if zsh installed
if ! command -v 'zsh' $> /dev/null
then
	echo "zsh package not installed, installing...\n"
	sudo apt-get install zsh
else
	echo "zsh package already installed"
fi

# check if tmux installed
if ! command -v 'tmux' $> /dev/null
then
	echo "tmux package not installed, installing...\n"
	sudo apt-get install tmux
else
	echo "tmux package already installed"
fi


# check if dotfiles installed
if ! command -v 'dotfiles' $> /dev/null
then
	echo "dotfiles package not installed, installing...\n"
    curl -fsSL https://dotfiles.wook.kr/etc/install | bash
else
	echo "dotfiles package already installed"
fi

# check if node js installed
if ! command -v 'node' $> /dev/null
then
	echo "node package not installed, installing...\n"
    dotfiles install node
else
	echo "node package already installed"
fi

# custom configurations
echo 'Adding custom configurations'
touch $HOME/.vimrc.local

echo 'se nu rnu
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

exec /bin/zsh
