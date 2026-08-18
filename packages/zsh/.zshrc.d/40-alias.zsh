# ~/.zshrc.d/40-alias.zsh

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
alias dkce="docker compose exec"

## git
alias g="git"
# ダブルクォート内でバックティックを使うと zsh の起動時に一度だけ展開され、
# その時のパスに固定されてしまうため、シングルクォートで囲む
alias gtop='cd "$(git rev-parse --show-toplevel)"'

### fzf（FZF_DEFAULT_OPTS などの設定は 60-tools.zsh 側にある）
alias prch='gh pr list | fzf | awk '\''{print $1}'\'' | xargs gh pr checkout'
alias prview='gh pr list | fzf | awk '\''{print $1}'\'' | xargs gh pr view --web'
