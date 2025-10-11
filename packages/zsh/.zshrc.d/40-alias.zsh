# ~/.zshrc.d/40-alias.zsh
print -P "%F{green}[zshrc] loaded 40-alias.zsh%f"

## utils
alias ls="eza"
alias ll="ls -l -g --icons"
alias la="ll -a"
alias cat="bat"

## docker
alias dk="docker"
alias dkv="docker volume"
alias dkn="docker network"
alias dka="docker attach"
alias dkc="docker compose"
alias dkm="docker-machine"
alias dkce="docker compose exec"

## git
alias g="git"
alias gtop="cd `git rev-parse --show-toplevel`"

### fzf
export FZF_DEFAULT_OPTS='--reverse --border'
alias prch='gh pr list | fzf | awk '\''{print $1}'\'' | xargs gh pr checkout'
alias prview='gh pr list | fzf | awk '\''{print $1}'\'' | xargs gh pr view --web'
