export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HISTSIZE=1000000
SAVEHIST=1000000

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)


find_and_cd() {
    local specific_dirs=(work personal aimfiles)
    local exclude_dirs=("node_modules" ".git")

    local find_cmd="find "
    for dir in "${specific_dirs[@]}"; do
        find_cmd+="~/$dir "
    done

    local exclude_cmd=" "
    for dir in "${exclude_dirs[@]}"; do
        exclude_cmd+="-a -not -path \"*$dir*\" "
    done
    
    find_cmd+="-maxdepth 2  -type d $exclude_cmd"

    local current_directory=$(pwd)
    # sed removes the $HOME dir from fzf, and when the path is selected sed adds it once again
    local selected_dir=$(eval "$find_cmd" | sed -e 's|'"$HOME"'|~|g' | fzf | sed -e 's|~|'"$HOME"'|g')

    z $selected_dir
}

find_inside_drives() {
    local partitions=(sda2 sdb5 sdb6 nvme1n1p2)
    local find_cmd="find "
    for partition in ${partitions[@]}
    do
        find_cmd+="/mnt/$partition "
    done

    find_cmd+="-mindepth 1 -maxdepth 2 "

    selected_dir=$(eval "$find_cmd" -type d | fzf )
    z $selected_dir
}

export FZF_DEFAULT_COMMAND='find --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=80%"
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
source $ZSH/oh-my-zsh.sh

alias ec="nvim ~/.zshrc"
alias sc="source ~/.zshrc"
alias s="find_and_cd"
alias sd="z \$(find * -type d | fzf)"
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
